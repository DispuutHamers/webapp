# Entry point for the quote resource
class QuotesController < ApplicationController
  before_action :ilid?
  breadcrumb 'Quotes', :quotes_path

  def index
    redirect_to root_path
  end

  def show
    redirect_to root_path
  end

  def create
    quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
    quote.reporter_id = current_user.id
    save_object(quote)
  end

  def edit
    @quote = Quote.find_by_id!(params[:id])
    @userid = @quote.user_id
    breadcrumb 'Wijzig citaat', edit_quote_path(@quote)
  end

  def update
    quote = Quote.find_by_id!(params[:id])
    update_object(quote, quote_params)
  end

  def destroy
    quote = Quote.find_by_id!(params[:id])
    delete_object(quote)
  end

  def anonymous
    quote = Quote.find_by_id!(params[:id])
    if (quote && quote.user_id == current_user.id) || current_user.admin?
      puts "Quote #{quote.id} is now anonymous"
      quote.anonymous = true
      quote.reporter = nil
      quote.user = nil
      # TODO go back in time and remove all versions of this quote
      if quote.save
        flash[:success] = 'Quote is nu anoniem'
        redirect_to root_path
      else
        flash.now[:error] = quote.errors.full_messages.join('<br>')
        render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
      end
    else
      flash.now[:error] = 'Alleen een admin of de eigenaar van een quote kan deze anoniem maken.'
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
    end
  end
end
