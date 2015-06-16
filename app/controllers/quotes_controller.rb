class QuotesController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:destroy, :edit, :update]

  def index
  end

  def create
    @quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
		@quote.reporter = current_user.id
    if @quote.save
      flash[:succes] = "Quote staat erop" 
			update_app("{ data: { quote: { user_id: \"#{@quote.user_id}\", text: \"#{@quote.text}\", date: \"#{@quote.created_at}\"} } }")
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
    redirect_to request.referer
  end
end
