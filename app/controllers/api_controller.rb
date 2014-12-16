class ApiController < ApplicationController
	before_action :check_api_key, except: [:noaccess]
	skip_before_filter :verify_authenticity_token, :only => [:POST]

  def GET
		@type = "user" if params[:request] == "user"
		@type = "quote" if params[:request] == "quote"
		@type = "event" if params[:request] == "event"
		@type = "beer" if params[:request] == "beer"
		@result = User.all if @type == "user" 
		@result = Quote.all if @type == "quote" 
		@result = Event.all if @type == "event" 
		@result = Beer.all if @type == "beer" 
  end

  def POST
		@type = "quote" if params[:request] == "quote"
		@type = "event" if params[:request] == "event"
		if @type == "quote" 
			@quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
			@quote.reporter = keyStore.user.id
			if @quote.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bas request"}]'
			end
		end
  end

  def PUT
  end

  def DESTROY
  end

	def noaccess
		render :status => :forbidden, :text => '[{"status":"403","error":"Forbidden"}]'
	end

	private 
		def check_api_key
			@keyStore = ApiKey.where(key: params[:key]).first
			redirect_to api_v1_noaccess_path(format: :json) unless @keyStore != nil && @keyStore.user != nil && @keyStore.user.lid?
		end

		def micropost_params
			params.require(:quote).permit(:user_id, :text)
		end
end
