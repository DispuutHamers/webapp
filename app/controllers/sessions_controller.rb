# Sessions controller
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && (user.lid? || user.alid?) && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Deze gegevens werken niet'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
