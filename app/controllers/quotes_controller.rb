class QuotesController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:destroy, :edit, :update]

  def index
  end

  def create
    @quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
    if @quote.save
      flash[:succes] = "Quote staat erop" 
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

	def edit
	end

	def update
	end

  def destroy
		@quote = Quote.find(params[:id])
    @quote.destroy
    flash[:succes] = "Zie je nooit meer terrug" 
    redirect_to root_url
  end


  private
    def micropost_params
      params.require(:quote).permit(:user_id, :text)
    end
end
