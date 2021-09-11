# Static pages controller
class StaticPagesController < ApplicationController
  before_action :ilid?, only: %i[trail revert]
  layout 'application_public', except: :trail

  def home
    return render 'frontpage' unless current_user&.active?

    @quote = current_user.quotes.build
    @pagy, @quotes = pagy(Quote.with_user.ordered, page: params[:page], items: 12)
    @next_event = Event.upcoming.order(date: :asc).first
    @trail = PaperTrail::Version.includes(:item).last(4).reverse
    @blogitems = Blogitem.last(4).reverse
    @random_beer = Beer.random.take

    render layout: 'application'
  end

  def privacy
    breadcrumb 'Privacy', privacy_path
  end

  def activate_account
    breadcrumb 'Account activeren', activate_account_path
  end

  def trail
    @pagy, @trail = pagy(PaperTrail::Version.includes(:item).all.order(created_at: "DESC"),
                         page: params[:page],
                         items: 20)
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
end
