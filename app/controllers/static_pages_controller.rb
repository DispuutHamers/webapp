class StaticPagesController < ApplicationController
  def home
    @beer = Beer.order("RAND()").first
    @quote = current_user.quotes.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
    @events = Event.order("date").where(['date >= ?', Date.today]).limit(10)
  end
end
