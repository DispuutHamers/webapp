class Api2::ApiController < ApplicationController
	before_action :restrict_access
	before_action :log_url
	include ParamsHelper
	#resource_description do
	#	  api_versions "2"
	#end

	resource_description do
		api_versions "2.0"
		formats ['json']

		name "Hamers API" 
		app_info "De hamers api docs"
	end

	api 'POST', '/register', 'Register a device for push notifications' 
	def register
	  @device = @key.user.devices.first || Device.new(device_params)
	  @device.user_id = @key.user.id
	  @device.update_attributes(device_params)
	  if @device.save
	    render :status => :created, :text => '[{"status":"201","message":"Created"}]'
	  else
	    render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
	  end
	end
	
	private

	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			@key = ApiKey.where(key: token).first
			@key && @key.user && @key.user.lid?
		end
	end

	def log_url
		ApiLog.new(key: @key.key, user_id: @key.user.id, ip_addr: request.remote_ip, resource_call: (request.method + ": " + request.original_fullpath + " " + params.to_s)).save
	end
	
end
