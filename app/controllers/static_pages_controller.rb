# Static pages controller
class StaticPagesController < ApplicationController
  before_action :ilid?, only: [:visitors, :trail, :revert, :statistics]

  def home
    return unless current_user&.active?
    @beer = Beer.order('RAND()').first
    @random_quote = Quote.unscoped.order('RAND()').first
    @quote = current_user.quotes.build
    @blog = Blogitem.last(5).reverse
    @quotes = Quote.with_user.all.order('created_at DESC').paginate(page: params[:page], :per_page => 10)
    @events = Event.order('date').where(['date >= ?', Date.today]).limit(5)
    @news = News.last(5).reverse
    @trail = PaperTrail::Version.includes(:item).last(5).reverse
  end

  def privacy
    breadcrumb 'Privacy', privacy_path
  end

  def invited
  end

  def console
    redirect_to root_path unless current_user&.dev?
  end

  def trail
    @trail = PaperTrail::Version.includes(:item).all.order(created_at: "DESC").paginate(page: params[:page], :per_page => 20)
    breadcrumb 'Log', trail_path

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
    @visitCountries = Visit.group(:country).count
    @visitOS = Visit.group(:os).count
    @visitSource = Visit.group(:referring_domain).count
    @visitReferrer = Visit.group(:referrer).count
    breadcrumb 'Statistics', :stats_path
  end

  def visitors
    if params[:ip]
      @visitors = Visit.where(ip: params[:ip]).paginate(page: params[:page])
    else
      @visitors = Visit.all.paginate(page: params[:page])
    end
    breadcrumb 'Visitors', :visitors_path
  end

  def visitor
    @visitors = Visit.where(visitor_token: params[:token]).paginate(page: params[:page])
    breadcrumb 'Visitor', :visitors_path
  end

  private
  def getCumulativeData(table)
    sum = 0
    table.unscoped.group_by_day('DATE(created_at)').count.map { |x, y| {x => (sum += y)} }.reduce({}, :merge)
  end
end
