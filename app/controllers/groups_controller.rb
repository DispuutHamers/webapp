#control usergroup flows
class GroupsController < ApplicationController
  before_action :admin_user?
  before_action :set_params

  def create
    @user.join_group(@group)
    redirect_to usergroups_user_path(@user)
  end

  def destroy
    @user.remove_group(@group)
    redirect_to usergroups_user_path(@user)
  end

  private

  def set_params
    param = params[:group]
    @user = User.find(param[:user_id])
    @group = Usergroup.find(param[:group_id])
  end
end
