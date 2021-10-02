class UsergroupsController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:create, :edit, :update, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Groepen', :groups_path

  def index
    @usergroups = Usergroup.all
    @group = Usergroup.new
  end

  def show
    breadcrumb @usergroup.name, group_path(@usergroup)
  end

  def new
    @usergroup = Usergroup.new
    breadcrumb "Groep toevoegen", new_usergroup_path
  end

  def create
    @usergroup = Usergroup.new(usergroup_params)
    if @usergroup.save
      redirect_to groups_path
    else
      render 'usergroups/index'
    end
  end

  def edit
    breadcrumb @usergroup.name, group_path(@usergroup)
    breadcrumb "Aanpassen", edit_usergroup_path(@usergroup)
  end

  def update
    update_object(@usergroup, usergroup_params)
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
