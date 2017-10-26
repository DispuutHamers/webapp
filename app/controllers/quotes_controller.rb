# Entry point for the quote resource
class QuotesController < ApplicationController
  before_action :ilid?

  def index
  end

  def create
    # TODO: create error message if micropost_params[:text] is nil/false
    quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
    quote.reporter = current_user.id
    save_object(quote, push=true)
  end

  def edit
    @quote = Quote.find(params[:id])
    @userid = @quote.user_id
  end

  def update
    quote = Quote.find(params[:id])
    update_by_owner_or_admin(quote, quote_params)
  end

  def destroy
    quote = Quote.find(params[:id])
    delete_object(quote)
  end
end
