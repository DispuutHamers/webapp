#entry point for the application parent class for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_user_location
  before_action :set_cache_buster
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :strict_transport_security
  before_action do
    Rack::MiniProfiler.authorize_request if current_user&.dev?
  end
  breadcrumb 'Home', :root_path

  include UtilHelper
  include ParamsHelper
  include ApplicationHelper

  def strict_transport_security
    response.headers['Strict-Transport-Security'] = "max-age=31536000; includeSubDomains" if request.ssl?
  end

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

  def logged_in?
    return true if current_user&.active?

    redirect_to signin_url, notice: 'Deze webapp is een safe space, voor toegang neem dus contact op met een der leden.'
    false
  end

  def admin_user?
    return true if logged_in? && current_user&.admin?

    redirect_to root_url, notice: 'Deze actie is momenteel alleen beschikbaar voor leden van het triumviraat.'
    false
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  private

  def store_user_location
    return unless request.get?
    return unless is_navigational_format?
    return if devise_controller?
    return if request.xhr?

    store_location_for(:user, request.fullpath)
  end
end
