
class ChugTypesController < ApplicationController
  before_action :ilid?
  before_action :set_chug_type, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adt categorieën', :chug_types_path

  def index
    @pagy, @chug_types = pagy(Chug_Type.all, page: params[:page])
  end

  def show
    @chugs = @chug_type.chugs
    breadcrumb @chug_type.name, chug_types_path(@chugs)
  end

  def edit
    breadcrumb @chug_type.name, chug_types_path(@chug_type)
    breadcrumb 'Wijzig adt categorie', chug_types_path(@chug_type)
  end

  def update
    update_object(@chug_type, chug_type_params)
  end

  def new
    @chug_type = Chug_Type.new
    breadcrumb 'Nieuwe adt categorie', new_chug_type_path
  end

  def create
    chug_type = Chug_Type.new(chug_type_params)
    save_object(chug_type)
  end

  def destroy
    delete_object(@chug_type)
  end

  private

  def set_chug_type
    @chug_type ||= Chug_Type.find_by_id!(params[:id])
  end
end
