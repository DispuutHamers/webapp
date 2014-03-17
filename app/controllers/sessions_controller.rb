class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper

  def new
  end  

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.approved? && user.authenticate(params[:session][:password]) 
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Deze gegevens werken niet'
      render signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
