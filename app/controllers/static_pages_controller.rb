class StaticPagesController < ApplicationController
  def home
		if signed_in?
			@beer = Beer.order("RAND()").first
			@rQuote = Quote.order("RAND()").first
			@quote = current_user.quotes.build 
			@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 8) 
			@events = Event.order("date").where(['date >= ?', Date.today]).limit(10)
			@news = News.last(5).reverse
		end
  end

	def console
		redirect_to root_path unless current_user and current_user.admin?
	end

	def statistics
		redirect_to root_path unless signed_in?
	end
end
