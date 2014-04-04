class GroupsController < ApplicationController
  include SessionsHelper
  before_action :admin_user

  def create
    @user = User.find(params[:group][:user_id])
    @group = Usergroup.find(params[:group][:group_id])
    @user.join_group!(@group)   
    redirect_to usergroups_user_path(@user)
  end

  def destroy
    @user = User.find(params[:group][:user_id])
    @group = Usergroup.find(params[:group][:group_id])
    @user.remove_group!(@group)
    redirect_to usergroups_user_path(@user)
  end
  
  private
    def admin_user
        redirect_to root_url, notice: "Niet genoeg access bitch" unless current_user.admin?
    end
end
