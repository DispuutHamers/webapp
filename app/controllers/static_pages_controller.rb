class StaticPagesController < ApplicationController
  include SessionsHelper
  def home
    @quote = current_user.quotes.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
  end

  def help
  end
end
