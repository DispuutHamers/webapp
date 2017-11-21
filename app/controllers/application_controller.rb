#entry point for the application parent class for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cache_buster
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action do
    if current_user&.dev?
      Rack::MiniProfiler.authorize_request
    end
  end

  include UtilHelper
  include ParamsHelper
  include ApplicationHelper

  def devise_mapping
    @devise_mapping ||= request.env["devise.mapping"]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def update_app(obj, action)
    keys = []
    Device.all.each do |d|
      keys << d.device_key
    end

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("android_app")
    n.registration_ids = keys
    n.priority = 'high'        # Optional, can be either 'normal' or 'high'
    n.content_available = true # Optional
    n.data = { object: obj.to_json,
               type: obj.class.name,
               action: action
    }
    n.save!
  end

  def logged_in?
    redirect_to signin_url, notice: 'Deze webapp is een save-space, voor toegang neem dus contact op met een der leden.' unless current_user&.active? 
  end

  def admin_user?
    logged_in?
    redirect_to root_url, notice: 'Deze actie is momenteel alleen beschikbaar voor leden van het triumviraat.' unless current_user&.admin?
  end
end
