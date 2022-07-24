class ChugsController < ApplicationController
  before_action :ilid?
  before_action :set_chug, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adtjes', :chug_path

  def show
    redirect_to chugtype_path(@chug.chugtype)
  end

  def new
    @chugtype = Chugtype.find_by_id!(params[:id])
    @chug = @chugtype.chugs.build(chugtype_id: @chugtype.id)

    breadcrumb @chugtype.name, chugtype_path(@chugtype)
    breadcrumb 'Nieuwe adt', new_chug_path(@chugtype)
  end

  def create
    chug = Chug.new(chug_params)
    chug.chugtype = Chugtype.find_by_id!(params[:id])
    save_object(chug)
  end
  
  def edit
    @chugtype = @chug.chugtype

    breadcrumb @chugtype.name, chugtype_path(@chugtype)
    breadcrumb "Adtjes", chugtype_path(@chugtype)
    breadcrumb "#{@chug.user.name}'s adt van #{@chug.secs}.#{format('%02d', @chug.milis)}s", chug_path(@chug)
    breadcrumb 'Wijzig Adt', edit_chug_path(@chug)
  end

  def update
    update_object(@chug, chug_params)
  end

  def destroy
    delete_object(@chug)
  end

  private

  def set_chug
    @chug ||= Chug.find_by_id!(params[:id])
  end
end
