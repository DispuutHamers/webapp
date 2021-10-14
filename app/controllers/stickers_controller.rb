# Sticker controller
class StickersController < ApplicationController
  before_action :ilid?
  before_action :correct_user, only: [:edit, :update]
  breadcrumb 'Stickers', :stickers_path


  def index
    @stickers = Sticker.all
  end

  def personal
    @stickers = Sticker.where(user_id: current_user.id).paginate(page: params[:page])
    breadcrumb 'Stickers aanpassen', personal_sticker_path
  end

  def new
    @sticker = Sticker.new
    breadcrumb 'Sticker plakken', new_sticker_path
  end

  def edit
    @sticker = Sticker.find_by_id!(params[:id])
    breadcrumb 'Sticker aanpassen', edit_sticker_path(@sticker)
  end

  def create
    @sticker = Sticker.new(sticker_params)
    @sticker.user_id = current_user.id
    return redirect_to stickers_path if @sticker.save
    
    render :new
  end

  def update
    sticker = Sticker.find_by_id!(params[:id])
    update_by_owner_or_admin(sticker, sticker_params)
  end

  def show
    redirect_to personal_sticker_path
  end

  def destroy
    sticker = Sticker.find_by_id!(params[:id])
    delete_object(sticker)
  end

  private
  def correct_user
    Sticker.find_by_id!(params[:id]).user_id == current_user.id || current_user.admin?
  end
end
