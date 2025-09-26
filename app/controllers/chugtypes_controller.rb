class ChugtypesController < ApplicationController
  before_action :ilid?
  before_action :set_chugtype, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Ad-categorieën', :chugtypes_path

  def index
    @pagy, @chugtypes = pagy(Chugtype.all.order('name ASC'), page: params[:page])
  end

  def show
    @pagy, @chugs_all_newest = pagy(Chug.newest(@chugtype), limit: params[:limit] || 10, page: params[:page])
    @chugs_unique = Chug.unique_not_extern(@chugtype) + Chug.extern(@chugtype)
    @chugs_unique_sorted = @chugs_unique.sort_by { |chug| [chug.time] }
    breadcrumb @chugtype.name, chugtype_path(@chugtype)
  end

  def edit
    breadcrumb @chugtype.name, chugtypes_path(@chugtype)
    breadcrumb 'Wijzig ad categorie', chugtypes_path(@chugtype)
  end

  def update
    update_object(@chugtype, chugtype_params)
  end

  def new
    @chugtype = Chugtype.new
    breadcrumb 'Nieuwe ad categorie', new_chugtype_path
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
