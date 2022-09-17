class ChugsController < ApplicationController
  before_action :ilid?
  before_action :set_chug, only: [:show, :edit, :update, :destroy]
  breadcrumb 'Adjes', :chug_path

  def show
    redirect_to chugtype_path(@chug.chugtype)
  end

  def new
    @chugtype = Chugtype.find_by_id!(params[:id])
    @chug = @chugtype.chugs.build(chugtype_id: @chugtype.id)

    breadcrumb @chugtype.name, chugtype_path(@chugtype)
    breadcrumb 'Nieuwe ad', new_chug_path(@chugtype)
  end

  def create
    chug = Chug.new(chug_params)
    chug.chugtype = Chugtype.find_by_id!(params[:id])
    if chug.user.id == current_user.id
      flash.now[:error] = 'Je gaat toch niet je eigen tijd noteren!'
      return render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
    save_object(chug)
  end

  def edit
    @chugtype = @chug.chugtype
    @userid = @chug.user_id

    breadcrumb @chugtype.name, chugtype_path(@chugtype)
    breadcrumb "Adjes", chugtype_path(@chugtype)
    breadcrumb "#{@chug.user.name}'s ad van #{@chug.time.round(2)}s", chug_path(@chug)
    breadcrumb 'Wijzig ad', edit_chug_path(@chug)
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
