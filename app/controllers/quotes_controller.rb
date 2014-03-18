class QuotesController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user
  before_action :admin_user, only: :destroy

  def index
  end

  def create
    @quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
    if @quote.save
      flash[:succes] = "Quote staat erop" 
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @quote.destroy
    flash[:succes] = "Zie je nooit meer terrug" 
    redirect_to root_url
  end


  private
    def admin_user
      redirect_to root_url, notice: "Niet genoeg access bitch" unless current_user.admin?
    end

   
    def micropost_params
      params.require(:quote).permit(:user_id, :text)
    end
    
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
