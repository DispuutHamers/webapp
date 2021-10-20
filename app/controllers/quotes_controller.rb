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
    breadcrumb 'Edit Quote', edit_quote_path(@quote)
  end

  def update
    quote = Quote.find_by_id!(params[:id])
    update_object(quote, quote_params)
  end

  def destroy
    quote = Quote.find_by_id!(params[:id])
    delete_object(quote)
  end
end
