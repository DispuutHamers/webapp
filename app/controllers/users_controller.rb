#user controller
class UsersController < ApplicationController
  before_action :logged_in?, except: [:new, :create, :index_public]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user?, only: [:destroy, :usergroups]

  def index
    @users = User.paginate(page: params[:page])
  end

  def index_public
    @users = User.order(batch: :desc).reject { |user| !user.lid? }.group_by {|user| user[:batch]}
  end

  def show
    @user = User.find(params[:id])
    @quotes = @user.quotes.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def usergroups
    @user = User.find(params[:id])
    @usergroups = Usergroup.all
  end

  def create
    user = User.new(user_params)
    save_object(user, type="user")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user_params = delete_empty_password(users_params)
    if @user.update_attributes(user_params)
      sign_in current_user
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    delete_object(user)
  end

  private
  def delete_empty_passwords(password_params)
    if passowrd_params[:password].blank?
      password_params.delete(:password)
      password_params.delete(:password_confirmation)
    end
    password_params
  end

  def skip_password_attribute
    if params[:password].blank? && params[:password_confirmation].blank?
      params.except!(:password, :password_confirmation)
    end
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to root_url, notice: 'Niet genoeg access' unless current_user?(user) or current_user.admin?
  end
end
