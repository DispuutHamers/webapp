class MicropostsController < ApplicationController
  before_action :signed_in_user

  def index
  end

  def create
    @quote = current_user.quotes.build(micropost_params)
    if @quote.save
      flash[:succes] = "Quote staat erop" 
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private
    def micropost_params
      params.require(:quote).permit(:reporter, :text)
    end
end
