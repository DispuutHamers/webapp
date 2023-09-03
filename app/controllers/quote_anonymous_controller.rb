# Entry point for the quotes_anonymous resource
class QuoteAnonymousController < ApplicationController
  before_action :ilid?

  def update
    quote = Quote.find_by_id!(params[:id])

    unless quote.can_be_anonymized_by?(current_user)
      flash.now[:error] = 'Je kan alleen je eigen quote anoniem maken'
      return render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end

    quote.user_id = nil
    quote.reporter_id = nil
    quote.save!
    redirect_to root_path
  end
end
