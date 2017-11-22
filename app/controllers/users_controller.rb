# user controller
class UsersController < ApplicationController
  before_action :logged_in?, except: [:new, :create, :index_public]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user?, only: [:index_extern, :destroy, :usergroups]

  def index
    @leden = User.leden
    @aspiranten = User.aspiranten
    @oudelullen = User.oud
  end

  def index_public
    @users = User.leden.order(batch: :desc).group_by {|user| user[:batch]}
  end

  def index_extern
    @users = User.all - User.leden - User.aspiranten - User.oud
  end

  def show
    @user = User.find(params[:id])
    @quotes = @user.quotes.order("created_at DESC").paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def usergroups
    @usergroups = Usergroup.all
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    save_object(user, type="user")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    update_object(user, user_params)
  end

  def destroy
    user = User.find(params[:id])
    delete_object(user)
  end

  private
  def correct_user
    user = User.find(params[:id])
    redirect_to root_url, notice: 'Niet genoeg access' unless current_user?(user) or current_user.admin?
  end
end
