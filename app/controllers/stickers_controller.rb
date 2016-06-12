class StickersController < ApplicationController
  before_action :logged_in?, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user?, only: [:destroy]

  def index
  end

	def new
		@sticker = Sticker.new
	end

	def edit
	end

  def create
  end

  def update
  end

  def show
  end

	def destroy
	end
end
