
class ChugtypesController < ApplicationController
  before_action :ilid?
  before_action :set_chugtype, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adt categorieën', :chugtypes_path

  def index
    @pagy, @chugtypes = pagy(Chugtype.all.order('name ASC'), page: params[:page])
  end

  def show
    @pagy, @chugs_all_newest = pagy(@chugtype.chugs.order('created_at DESC'), items: 10, page: params[:page])
    @chugs_unique = @chugtype.chugs.includes(:user).order('secs ASC, milis ASC, created_at DESC').distinct(:user_id)
    @chugs_unique.each { |chug|
      chug.user = User.find_by_id(chug.user_id)
    }
    @chugs_unique = @chugs_unique.sort_by { |chug|
      [chug.secs, chug.milis]
    }
    @chugs_unique = @chugs_unique.reverse
    @chugs_unique = @chugs_unique.uniq { |chug|
      [chug.user_id, chug.secs, chug.milis]
    }
    breadcrumb @chugtype.name, chugtype_path(@chugtype)
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
