class StaticPagesController < ApplicationController
  include SessionsHelper
  def home
    @quote = current_user.quotes.build if signed_in?
  end

  def help
  end
end
