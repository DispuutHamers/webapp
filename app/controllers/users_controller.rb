# user controller
class UsersController < ApplicationController
  before_action :ilid?, except: [:edit, :update, :new, :create, :index_public]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user?, only: [:admin, :index_extern, :destroy, :usergroups]
  breadcrumb 'Leden', :users_path

  def index
    @leden = User.leden
    @aspiranten = User.aspiranten
    @oudelullen = User.oud
  end

  def admin
    @leden = User.leden
    @aspiranten = User.aspiranten
    @oudelullen = User.oud
    breadcrumb 'Admin', leden_admin_path
  end

  def admin_patch
    User.find(params[:id]).update_attributes(user_params)
  end

  def index_public
    @users = User.leden.order(batch: :desc).group_by {|user| user[:batch]}
    breadcrumb 'Openbaar', public_leden_path
  end

  def index_extern
    @users = User.all - User.leden - User.aspiranten - User.oud
    breadcrumb 'Extern', external_accounts_path
  end

  def show
    @user = User.find(params[:id])
    @quotes = @user.quotes.order('created_at DESC').paginate(page: params[:page])
    breadcrumb @user.name, user_path(@user)
  end

  def new
    @user = User.new
    breadcrumb 'Registreren', new_user_path
  end

  def usergroups
    @usergroups = Usergroup.all
    @user = User.find(params[:id])
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Groepen', usergroups_user_path(@user)
  end

  def create
    save_object(User.new(user_params))
  end

  def edit
    @user = User.find(params[:id])
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
  end

  def update
    user = User.find(params[:id])
    update_object(user, user_params)
  end

  def destroy
    user = User.find(params[:id])
    user.groups.each(&:destroy)
    redirect_to users_path
  end

  private

  def correct_user
    user = User.find(params[:id])
    redirect_to root_url, notice: 'Je mag alleen je eigen profiel editen.' unless current_user?(user) or current_user.admin?
  end
end
