#Static pages controller
class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @beer = Beer.order('RAND()').first
      @rQuote = Quote.unscoped.order('RAND()').first
      @quote = current_user.quotes.build
      @feed_items = Quote.all.order("created_at DESC").paginate(page: params[:page], :per_page => 8)
      @events = Event.order('date').where(['date >= ?', Date.today]).limit(10)
      @news = News.last(5).reverse
    end
  end

  def console
    redirect_to root_path unless current_user && current_user.admin?
  end

  def trail
    redirect_to root_path unless current_user && current_user.admin?
    @trail = PaperTrail::Version.all.order(created_at: "DESC").paginate(page: params[:page], :per_page => 20)
  end

  def statistics
    redirect_to root_path unless signed_in?
    @cumulativeReviewData = getCumulativeData Review
    @cumulativeBeerData = getCumulativeData Beer
    @cumulativeQuoteData = getCumulativeData Quote
    @cumulativeEventData = getCumulativeData Event
  end

  private
  def getCumulativeData(table)
    sum = 0
    table.unscoped.order('created_at asc').group('DATE(created_at)').count.map { |x, y| {x => (sum += y)} }.reduce({}, :merge)
  end
end
