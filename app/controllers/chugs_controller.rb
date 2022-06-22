class BrewsController < ApplicationController
  before_action :ilid?
  before_action :set_brew, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adtjes', :chug_path

  def show
    @chug_type = @chug.chug_type

    breadcrumb @chug_type.name, chug_types_path(@chug_type)
    breadcrumb "Adtjes", chug_types_path(@chug_type)
    breadcrumb @chug.created_at.strftime("%d-%m-%Y"), chug_path(@chug)
  end

  def new
    @chug_type = Chug_Type.find_by_id!(params[:id])
    @chug = @chug_type.chugs.build(recipe_id: @chug_type.id)

    breadcrumb @chug_type.name, chug_type_path(@chug_type)
    breadcrumb 'Nieuwe adt', new_chug_path(@recipe)
  end

  def create
    chug = Chug.new(chug_params)
    chug.chug_type = Chug_Type.find_by_id!(params[:id])
    save_object(chug)
  end

  def edit
    @chug_type = @chug.chug_type

    breadcrumb @chug_type.name, chug_type_path(@chug_type)
    breadcrumb "Adtjes", chug_type_path(@chug_type)
    breadcrumb @chug_type.created_at.strftime("%d-%m-%Y"), chug_path(@brew)
    breadcrumb 'Wijzig', edit_chug_path(@chug)
  end

  def update
    update_object(@chug, chug_params)
  end

  def destroy
    delete_object(@chug)
  end

  private

  def set_brew
    @chug ||= Chug.find_by_id!(params[:id])
  end
end
