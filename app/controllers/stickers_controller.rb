#Sticker controller
class StickersController < ApplicationController
  before_action :logged_in?, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user?, only: [:destroy]

  def index
    @stickers = Sticker.all
  end

  def personal
    @stickers = Sticker.where(user_id: current_user.id).paginate(page: params[:page])
  end

  def new
    @sticker = Sticker.new
  end

  def edit
  end

  def create
    sticker = Sticker.new(sticker_params)
    sticker.user_id = current_user.id
    save_object(sticker, type="sticker")
  end

  def update
  end

  def show
  end

  def destroy
    sticker = Sticker.find(params[:id])
    delete_object(sticker)
  end
end
