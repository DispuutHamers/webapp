class UsersController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end   

  def show
    @user = User.find(params[:id])
    @quotes = @user.quotes.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Wacht tot iemand je account enabled."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    if @user.update_attributes(user_params)
      sign_in current_user
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  private
  
    def skip_password_attribute
      if params[:password].blank? && params[:password_confirmation].blank?
        params.except!(:password, :password_confirmation)
      end
    end

    def admin_user
      redirect_to root_url, notice: "Niet genoeg access bitch" unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :approved,
                                   :password_confirmation)
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url, notice: "Niet genoeg access" unless current_user?(@user) or @user.admin?
    end
end
