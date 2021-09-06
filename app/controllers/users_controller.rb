class UsersController < ApplicationController
  before_action :ilid?, except: [:edit, :update, :new, :create, :index_public]
  before_action :user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  breadcrumb 'Leden', :users_path

  def index
    @leden = User.leden
    @aspiranten = User.aspiranten
    @oudelullen = User.oud
    @extern = User.extern
  end

  def index_public
    @users = User.order(batch: :desc).group_by { |user| user[:batch] }
    breadcrumb 'Openbaar', public_leden_path
  end

  def show
    @quotes = @user.quotes.order('created_at DESC').paginate(page: params[:page])
    @missed_drinks = UsersHelper.missed_drinks_for(@user) if @user.lid?
    breadcrumb @user.name, user_path(@user)
  end

  def new
    @user = User.new
    breadcrumb 'Registreren', new_user_path
  end

  def create
    save_object(User.new(user_params))
  end

  def edit
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
  end

  def update
    update_object(@user, user_params)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def correct_user
    redirect_to root_url, notice: 'Je mag alleen je eigen profiel editen.' unless @user == current_user || current_user.admin?
  end
end
