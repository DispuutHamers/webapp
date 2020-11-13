# Static pages controller
class StaticPagesController < ApplicationController
  before_action :ilid?, only: %i[trail revert statistics]

  def home
    return unless current_user&.active?

    @random_beer = Beer.unscoped.order('RAND()').first
    @random_quote = Quote.unscoped.order('RAND()').first
    @quote = current_user.quotes.build
    @blog = Blogitem.last(5).reverse
    @quotes = Quote.with_user.all.order('created_at DESC').paginate(page: params[:page], :per_page => 12)
    @events = Event.order('date').where(['date >= ?', Date.today]).limit(5)
    @news = News.last(5).reverse
    @trail = PaperTrail::Version.includes(:item).last(5).reverse
  end

  def privacy
    breadcrumb 'Privacy', privacy_path
  end

  def activate_account
    breadcrumb 'Account activeren', activate_account_path
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
    @cumulative_review_data = get_cumulative_data Review
    @cumulative_beer_data = get_cumulative_data Beer
    @cumulative_quote_data = get_cumulative_data Quote
    @cumulative_event_data = get_cumulative_data Event
    @cumulative_user_data = get_cumulative_data User
    @cumulative_sticker_data = get_cumulative_data Sticker
    @cumulative_meeting_data = get_cumulative_data Meeting
    @cumulative_news_data = get_cumulative_data News
    breadcrumb 'Statistics', :stats_path
  end

  private

  def get_cumulative_data(table)
    sum = 0
    table.unscoped.group_by_day('DATE(created_at)').count.map { |x, y| {x => (sum += y)} }.reduce({}, :merge)
  end
end
