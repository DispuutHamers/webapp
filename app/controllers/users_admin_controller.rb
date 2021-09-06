class UsersAdminController < ApplicationController
  before_action :user, only: [:usergroups, :destroy]
  before_action :admin_user?, only: [:index, :destroy, :usergroups]
  breadcrumb 'Leden', :users_path
  breadcrumb 'Administratie', :admin_users_path

  def index
    @leden = User.leden
    @aspiranten = User.aspiranten
    @oudelullen = User.oud
    @extern = User.extern
  end

  def admin_patch
    User.find(params[:id]).update(user_params)
  end

  def usergroups
    @member = @user.usergroups
    @notmember = Usergroup.where.not(id: @member)
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Groepen', usergroups_user_path(@user)
  end

  def destroy
    @user.groups.each(&:destroy)
    redirect_to users_path
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
