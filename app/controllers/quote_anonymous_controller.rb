# Entry point for the quotes_anonymous resource
class QuoteAnonymousController < ApplicationController
  before_action :ilid?

  def show
    quote = Quote.find_by_id!(params[:id])

    if quote.user_id != current_user.id && !current_user.admin?
      flash.now[:error] = 'Je kan alleen je eigen quote anoniem maken'
      return render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end

    quote.user_id = nil
    quote.reporter_id = nil
    quote.save!
    quote.destroy_history
    redirect_to quote_path(quote)
  end
end
