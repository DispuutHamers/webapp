# Static pages controller
class StaticPagesController < ApplicationController
  before_action :ilid?, only: [:trail, :revert, :statistics]

  def home
    return unless current_user&.active?
    @beer = Beer.order('RAND()').first
    @random_quote = Quote.order('RAND()').first
    @quote = current_user.quotes.build
    @blog = Blogitem.last(3).reverse
    @feed_items = Quote.with_user.all.order("created_at DESC").paginate(page: params[:page], :per_page => 8)
    @events = Event.order('date').where(['date >= ?', Date.today]).limit(5)
    @news = News.last(5).reverse
    @trail = PaperTrail::Version.last(5).reverse
  end

  def console
    redirect_to root_path unless current_user&.dev?
  end

  def trail
    @trail = PaperTrail::Version.all.order(created_at: "DESC").paginate(page: params[:page], :per_page => 20)
  end

  def revert
    m = params[:model].constantize.unscoped.find(params[:id])
    m = m.paper_trail.previous_version
    m.save
    redirect_to root_path
  end

  def quote
    redirect_to root_path
  end

  def statistics
    @cumulativeReviewData = getCumulativeData Review
    @cumulativeBeerData = getCumulativeData Beer
    @cumulativeQuoteData = getCumulativeData Quote
    @cumulativeEventData = getCumulativeData Event
    @cumulativeUserData = getCumulativeData User
    @cumulativeStickerData = getCumulativeData Sticker
    @cumulativeMeetingData = getCumulativeData Meeting
    @cumulativeNewsData = getCumulativeData News
  end

  private
  def getCumulativeData(table)
    sum = 0
    table.unscoped.group_by_day('DATE(created_at)').count.map { |x, y| {x => (sum += y)} }.reduce({}, :merge)
  end
end
