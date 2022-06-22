
class ChugtypesController < ApplicationController
  before_action :ilid?
  before_action :set_chugtype, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adt categorieën', :chugtypes_path

  def index
    @pagy, @chugtypes = pagy(Chugtype.all, page: params[:page])
  end

  def show
    @chugs = @chugtype.chugs
    breadcrumb @chugtype.name, chugtypes_path(@chugs)
  end

  def edit
    breadcrumb @chugtype.name, chugtypes_path(@chugtype)
    breadcrumb 'Wijzig adt categorie', chugtypes_path(@chugtype)
  end

  def update
    update_object(@chugtype, chugtype_params)
  end

  def new
    @chugtype = Chugtype.new
    breadcrumb 'Nieuwe adt categorie', new_chugtype_path
  end

  def create
    chugtype = Chugtype.new(chugtype_params)
    save_object(chugtype)
  end

  def destroy
    delete_object(@chugtype)
  end

  private

  def set_chugtype
    @chugtype ||= Chugtype.find_by_id!(params[:id])
  end
end
