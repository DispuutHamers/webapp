
class ChugtypesController < ApplicationController
  before_action :ilid?
  before_action :set_chugtype, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adt categorieën', :chugtypes_path

  def index
    @pagy, @chugtypes = pagy(Chugtype.all.order('name ASC'), page: params[:page])
  end

  def show
    @pagy, @chugs_all_newest = pagy(@chugtype.chugs.order('created_at DESC'), items: 10, page: params[:page])
    # @chugs_unique = @chugtype.chugs.order('secs ASC, milis ASC, created_at ASC').distinct('user_id') # distinct on user_id doesn't seem to work.
    # @chugs_unique = @chugtype.chugs.all.group_by(&:user_id).map { |k, v| [k, v.first] } # returns array type, kinda hard to then have the link_to stuff + wanna keep it clean
    # @chugs_unique = Chug.all.order('secs ASC, milis ASC, created_at ASC')
    #                     .select{|chug| chug.chugtype == @chugtype}
    #                     .uniq{|chug| chug.user}
    #                     .sort_by{|chug| [chug.secs, chug.milis]} # somehow this is not always correct, not sure why..
    @chugs_unique = @chugtype.chugs.order('secs ASC, milis ASC, created_at ASC')
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
