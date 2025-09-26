class UsersController < ApplicationController
  before_action :ilid?, except: %i[new create index_public edit_two_factor update_two_factor]
  before_action :user, except: %i[index index_public new create]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user?, only: :destroy
  breadcrumb 'Leden', :users_path
  layout 'application_public', only: :index_public

  def index
    @leden = User.leden
    @aspiranten = User.aspiranten
    @oudelullen = User.oud
    @extern = User.extern
  end

  def index_public
    breadcrumb 'Openbaar', public_leden_path
    @users = User.order(batch: :desc).group_by { |user| user[:batch] }
  end

  def edit_usergroups
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb 'Groepen', edit_usergroups_user_path(@user)

    @member = @user.usergroups
    @notmember = Usergroup.where.not(id: @member)
    render 'users/settings/usergroups'
  end

  def show
    breadcrumb @user.name, user_path(@user)

    @pagy, @quotes = if current_user.can_view_quotes?
                       pagy(@user.quotes.ordered, limit: params[:limit] || 25, page: params[:page])
                     else
                       pagy(Quote.where(user_id: 0), page: params[:page])
                     end
    @missed_drinks = UsersHelper.missed_drinks_for(@user) unless @user.olid?
  end

  def new
    breadcrumb 'Registreren', new_user_path

    @user = User.new
  end

  def create
    save_object(User.new(user_params))
  end

  def edit
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)

    render 'users/settings/main'
  end

  def update
    update_object(@user, user_params)
  end

  def edit_two_factor
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb '2FA', edit_two_factor_user_path(@user)

    # we must check user because we cannot call ilid because of an endless redirect
    unless current_user&.active?
      redirect_to signin_url, notice: 'Deze webapp is een safe space, voor toegang neem dus contact op met een der leden.'
      return false
    end

    if @user.otp_required_for_login
      render 'users/settings/two_already_enabled'
    else
      @secret = User.generate_otp_secret
      @user.otp_secret = @secret
      url = @user.otp_provisioning_uri("hamers:#{@user.email}", issuer: "Hamers zonder Sikkel")
      @qrcode = RQRCode::QRCode.new(url)

      render 'users/settings/edit_two_factor'
    end
  end

  def update_two_factor
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb '2FA', edit_two_factor_user_path(@user)

    if params[:commit] == "Enable"
      @user.otp_required_for_login = true
      @user.otp_secret = params[:otp_secret]
      @codes = @user.generate_otp_backup_codes!
      @user.save!

      render "users/settings/two_already_enabled", notice: "2FA staat aan 👍"
    else
      @user.otp_required_for_login = false
      @user.save!

      @secret = User.generate_otp_secret
      @user.otp_secret = @secret
      url = @user.otp_provisioning_uri("hamers:#{@user.email}", issuer: "Hamers zonder Sikkel")
      @qrcode = RQRCode::QRCode.new(url)

      render "users/settings/edit_two_factor", notice: "2FA staat weer uit 😭"
    end
  end

  def edit_password
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb 'Wachtwoord', edit_password_user_path(@user)

    render 'users/settings/password'
  end

  def update_password
    @user = current_user
    if @user.update(user_password_params)
      # Sign in the user bypassing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to
    else
      render "users/settings/password"
    end
  end

  def destroy
    @user.groups.each(&:destroy)
    redirect_to users_path
  end

  private

  def user
    @user ||= User.find_by_id!(params[:id])
  end

  def correct_user
    redirect_to root_url, notice: 'Je mag alleen je eigen profiel editen.' unless @user == current_user || current_user.admin?
  end
end
