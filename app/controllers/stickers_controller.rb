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
    breadcrumb 'Stickers Aanpassen', personal_sticker_path
  end

  def new
    @sticker = Sticker.new
    breadcrumb 'Sticker Plakken', new_sticker_path
  end

  def edit
    @sticker = Sticker.find(params[:id])
    breadcrumb 'Sticker Aanpassen', edit_sticker_path(@sticker)
  end

  def create
    sticker = Sticker.new(sticker_params)
    sticker.user_id = current_user.id
    save_object(sticker, push=true)
  end

  def update
    sticker = Sticker.find(params[:id])
    update_by_owner_or_admin(sticker, sticker_params)
  end

  def show
    redirect_to personal_sticker_path
  end

  def destroy
    sticker = Sticker.find(params[:id])
    delete_object(sticker)
  end

  private
  def correct_user
    Sticker.find(params[:id]).user_id == current_user.id || current_user.admin?
  end
end
