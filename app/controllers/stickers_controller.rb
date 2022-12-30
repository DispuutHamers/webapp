# Sticker controller
class StickersController < ApplicationController
  before_action :ilid?
  before_action :correct_user, only: [:edit, :update]
  breadcrumb 'Stickers', :stickers_path


  def index
    @stickers = Sticker.all
  end

  def personal
    @pagy, @stickers = pagy(current_user.stickers, page: params[:page])
    breadcrumb 'Jouw stickers', personal_stickers_path
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
    save_object(@sticker)
  end

  def update
    sticker = Sticker.find_by_id!(params[:id])
    update_by_owner_or_admin(sticker, sticker_params)
  end

  def show
    sticker = Sticker.find_by_id!(params[[:id]])
    if sticker.user.id == current_user.id
      redirect_to personal_stickers_path
      return
    end
    redirect_to stickers_path
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
