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
    @sticker = Sticker.new(sticker_params)
		@sticker.user_id = current_user.id
    if @sticker.save
      flash[:success] = 'Sticker geplakt'
      redirect_to root_url
    else
			flash[:danger] = "Je sticker liet weer los :("
			redirect_to root_url
    end
  end

  def update
  end

  def show
  end

	def destroy
	end
end
