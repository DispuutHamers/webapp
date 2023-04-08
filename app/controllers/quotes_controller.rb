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

  def anonymous_error(text)
    flash.now[:error] = text
    render turbo_stream: turbo_stream.update('flash', partial: 'layouts/alert')
  end

  def anonymous
    quote = Quote.find_by_id!(params[:id])
    return anonymous_error('Alleen de eigenaar van een quote of een admin kan deze anoniem maken.') if quote.user_id != current_user.id && !current_user.admin?
    return anonymous_error('Deze quote is al anoniem.') if quote.anonymous?
    return anonymous_error(quote.errors.full_messages.join('<br>').html_safe) unless quote.update(anonymous: true, reporter: nil, user: nil)
    flash[:success] = 'Quote is nu anoniem'
    redirect_to root_path
  end
end
