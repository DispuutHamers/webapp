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
      update_app("{ data: { quote: { id: \"#{@quote.id}\", user_id: \"#{@quote.user_id}\", text: \"#{@quote.text}\", created_at: #{@quote.created_at.to_json}} } }")
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @quote = Quote.find(params[:id])
    @userid = @quote.user_id
  end

  def update
    @quote = Quote.find(params[:id])
    if @quote.update(micropost_params)
      flash[:success] = "Quote aangepast"
      redirect_to root_path 
    end
  end

  def destroy
		@quote = Quote.find(params[:id])
    @quote.destroy
    flash[:succes] = "Zie je nooit meer terrug" 
    redirect_to request.referer
  end
end
