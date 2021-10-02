class UsergroupsController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:create, :destroy]
  before_action :set_group, only: [:show, :destroy]
  breadcrumb 'Groepen', :groups_path

  def index
    @usergroups = Usergroup.all
    @group = Usergroup.new
  end

  def show
    breadcrumb @usergroup.name, group_path(@usergroup)
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
    if @usergroup.empty?
      @usergroup.destroy!
    else
      flash[:error] = "De groep moet leeg zijn voor je deze kunt verwijderen!"
    end
    redirect_to groups_path
  end

  private

  def set_group
    @usergroup  ||= Usergroup.find_by_id!(params[:id])
  end
end
