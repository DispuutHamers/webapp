class UsergroupsController < ApplicationController
  before_action :ilid?
  before_action :admin_user?, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Groepen', :usergroups_path

  def index
    @usergroups = Usergroup.all
    @group = Usergroup.new
  end

  def show
    breadcrumb @usergroup.name, usergroup_path(@usergroup)
  end

  def new
    @usergroup = Usergroup.new
    breadcrumb "Groep toevoegen", new_usergroup_path
  end

  def create
    @usergroup = Usergroup.new(usergroup_params)
    if @usergroup.save
      redirect_to usergroup_path(@usergroup)
    else
      render 'usergroups/new'
    end
  end

  def edit
    breadcrumb @usergroup.name, usergroup_path(@usergroup)
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
    @usergroup  ||= Usergroup.includes(:users).find_by_id!(params[:id])
  end
end
