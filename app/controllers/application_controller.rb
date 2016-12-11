class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_cache_buster
  include SessionsHelper
  include ParamsHelper

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def update_app(data)
    keys = []
    Device.all.each do |d|
      keys << d.device_key
    end

    Push.new(data: PUSH.send(keys, eval(data))).save
    Push.new(data: eval(data)).save
  end

  def logged_in?
    redirect_to signin_url, notice: 'Please sign in.' unless signed_in?
  end

  def admin_user?
    logged_in?
    redirect_to root_url, notice: 'Niet genoeg access bitch' unless (current_user.admin? || current_user.schrijf_feut?)
  end
end
