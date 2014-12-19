class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	include SessionsHelper
	include ParamsHelper

    def logged_in?
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def admin_user?
			logged_in?
      redirect_to root_url, notice: "Niet genoeg access bitch" unless (current_user.admin? || current_user.schrijf_feut?)
    end
end
