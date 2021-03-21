# Usergroup controller
class UsergroupsController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:create, :destroy]
  breadcrumb 'Groepen', :groups_path

  def index
    @usergroups = Usergroup.all
    @group = Usergroup.new
  end

  def create
    @group = Usergroup.new(usergroup_params)
    if @group.save
      redirect_to groups_path
    else
      render 'usergroups/index'
    end

  end

  def destroy
    usergroup = Usergroup.find(params[:id])
    if usergroup.empty?
      usergroup.destroy!
    else
      flash[:error] = "De groep moet leeg zijn voor je deze kunt verwijderen!"
    end
    redirect_to groups_path
  end

  private
  def usergroup_params
    params.require(:usergroup).permit(:name, :text)
  end
end
