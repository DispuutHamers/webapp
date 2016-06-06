class Api2::ApiController < ApplicationController
	before_action :restrict_access
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

	private

	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			@key = ApiKey.where(key: token).first
			@key && @key.user && @key.user.lid?
		end
	end
end
