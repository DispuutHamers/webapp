# Entry point for the quote resource
class QuotesController < ApplicationController
  before_action :logged_in?
  before_action :admin_user?, only: [:destroy, :edit, :update]

  def index
  end

  def create
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
