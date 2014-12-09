class ApiController < ApplicationController
	layout false
	before_action :check_api_key, except: [:noaccess]

  def GET
		@type = "user" if params[:request] == "user"
		@type = "quote" if params[:request] == "quote"
		@result = User.all if @type == "user" 
		@result = Quote.all if @type == "quote" 
  end

  def POST
  end

  def PUT
  end

  def DESTROY
  end

	def noaccess
		render :status => :forbidden, :text => '{"status":"403","error":"Forbidden"}'
	end

	private 
		def check_api_key
			key = params[:key]
			keyStore = ApiKey.where(key: key).first
			redirect_to api_v1_noaccess_path unless keyStore != nil && @user = keyStore.user && @user.lid?
		end
end
