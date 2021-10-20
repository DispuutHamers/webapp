# Static pages controller
class StaticPagesController < ApplicationController
  before_action :lid?, only: %i[trail revert]
  layout 'application_public', except: :trail

  def home
    return render 'frontpage' unless current_user&.active?

    @quote = current_user.quotes.build
    @quotes = Quote.with_user.ordered.paginate(page: params[:page], :per_page => 12)
    @events = Event.order('date').where(['date >= ?', Date.today]).limit(5)
    @news = News.last(5).reverse
    @trail = PaperTrail::Version.includes(:item).last(5).reverse
    @blog = if current_user.alid?
              Blogitem.where(public: true).last(5).reverse
            else
              Blogitem.last(5).reverse
            end
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
