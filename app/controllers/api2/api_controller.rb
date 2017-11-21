#The ApiController is the main entry point for every controller in the api
# Default methods and authentication are handled here
class Api2::ApiController < ApplicationController
  attr_reader :key
  before_action :restrict_access
  before_action :log_url
  skip_before_action :verify_authenticity_token
  include ParamsHelper
  #resource_description do
  #	  api_versions "2"
  #end

  def initialize
    @key = ApiKey.new
  end

  resource_description do
    api_versions "2.0"
    formats ['json']

    name "Hamers API"
    app_info "Documentatie van de Hamers zonder Sikkel API\n\nVoor alles requests is het vereist een API key te gebruiken. Dit word gedaan door een \"Authorization\" header mee te sturen met daarin: \"Token token=<key>\""
  end

  api 'POST', '/register', 'Register a device for push notifications'
  param :device, String, required: true
  def register
    user = @key.user
    device = user.devices.first || Device.new
    device.assign_attributes(user_id: user.id, device_key: params[:device])
    if device.save
      render :status => :created, :plain => '{"status":"201","message":"Created"}'
    else
      render :status => :bad_request, :plain => '{"status":"400","error":"Bad request"}'
    end
  end

  private
  def restrict(admin = nil)
    return if dev_environment
    authenticate_or_request_with_http_token do |token, options|
      @key = ApiKey.where(key: token).first
      admin ? @key&.user&.admin? : @key&.user&.active? 
    end
  end

  def restrict_to_admins
    restrict(true)
  end

  def restrict_access
    restrict
  end

  def save_object(obj, push = nil)
    if obj.save
      update_app(obj, "create") if push
      render json: obj, status: :created, location: obj
    else
      render json: obj.errors, status: :unprocessable_entity
    end
  end

  def update_object(obj, obj_params)
    if obj.update(obj_params)
      render json: obj, status: :created, location: obj
    else 
      render json: obj.errors, status: :unprocessable_entry
    end
  end

  def update_by_owner_or_admin(obj, obj_params)
    user = key.user
    if (obj.user_id != user.id and !user.admin?)
      render text: "HTTP Token: Access denied.", status: :access_denied
    else
      update_object(obj, obj_params)
    end
  end

  def log_url
    id = @key.user.id
    resource_descriptor = (request.method + ": " + request.original_fullpath + " " + params.to_s)
    PaperTrail.whodunnit = id
    ApiLog.new(key: @key.key, user_id: id, ip_addr: request.remote_ip, resource_call: resource_descriptor).save
  end

  private 
  def dev_environment
    if Rails.env.development?
      @key = User.first.api_keys.first
      return true
    end
    return false
  end

end
