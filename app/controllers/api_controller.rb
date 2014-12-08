class ApiController < ApplicationController
	layout false
	before_action :check_api_key, except: [:noaccess]

  def GET
		@type = "user" if params[:request] = "user"
		@type = "quote" if params[:request] = "user"
		@result = User.all if @type = "user" 
		@result = Quote.all if @type = "quote" 
  end

  def POST
  end

  def PUT
  end

  def DESTROY
  end

	def noaccess
	end

	private 
		def check_api_key
			key = params[:key]
			@user = ApiKey.where(key: key).first.user
			redirect_to api_v1_noaccess_path unless @user != nil && @user.lid?
		end
end
