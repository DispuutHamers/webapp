class StaticPagesController < ApplicationController
  def home
    @beer = Beer.find(:all, :limit => 1, :order => "RAND()")
    @quote = current_user.quotes.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
    @events = Event.find(:all, 
        :order => "date", 
        :conditions => ['date >= ?', Date.today],
        :limit => "10"
        )
  end
end
