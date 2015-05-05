class ApiController < ApplicationController
	before_action :check_api_key, except: [:noaccess]
	skip_before_filter :verify_authenticity_token, :only => [:POST]

  def GET
		@type = "user" if params[:request] == "user"
		@type = "quote" if params[:request] == "quote"
		@type = "event" if params[:request] == "event"
		@type = "beer" if params[:request] == "beer"
		@type = "review" if params[:request] == "review"
		@type = "signup" if params[:request] == "signup" and params[:id] != nil
		@type = "news" if params[:request] == "news"
		@result = User.all if @type == "user" 
		@result = Event.find(params[:id]).signups if @type == "signup"
		@result = Quote.all if @type == "quote" and params[:id] == nil
		@result = User.find(params[:id]) if @type == "quote" and params[:id] != nil
		@result = Event.all.order("date") if @type == "event" 
		@result = Beer.all if @type == "beer" 
		@result = Review.all if @type == "review" and params[:id] == nil 
		@result = Beer.find(params[:id]).reviews if @type == "review" and params[:id] != nil
	  @result = News.all if @type == "news" 	
  end

  def POST
		@type = "quote" if params[:request] == "quote"
		@type = "event" if params[:request] == "event"
		@type = "review" if params[:request] == "review"
		@type = "motie" if params[:request] == "motie"
		@type = "beer" if params[:request] == "beer"
		@type = "signup" if params[:request] == "signup"
		@type = "news" if params[:request] == "news"
		if @type == "quote" 
			@quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
			@quote.reporter = @keyStore.user.id
			if @quote.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
			end
		end
		if @type == "news" 
			@news = News.new(news_params)
			@news.user_id = @keyStore.user.id
			if @news.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
			end
		end
		if @type == "event" 
			@event = Event.new(event_params)
			@event.user_id = @keyStore.user.id
			if @event.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
			end
		end
		if @type == "review" 
			@review = Review.new(review_params) 
			@review.user_id = @keyStore.user.id
			if !Review.where(user_id: @review.user_id, beer_id: @review.beer_id).any? and @review.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
			end
		end
		if @type == "motie"
			@motie = Motion.new(motion_params)
			@motie.user_id = @keyStore.user.id
			if @motie.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
			end
		end
		if @type == "beer"
			@beer = Beer.new(beer_params)
			if @beer.save 
				render :status => :created, :text => '[{"status":"201","message":"Created"}]'
			else
				render :status => :bad_request, :text => '[{"status":"400","error":"Bad request"}]'
			end
		end
		if @type == "signup"
			@keyStore.user.sign!(Event.find(params[:signup][:event_id]), params[:signup][:status])
			render :status => :created, :text => '[{"status":"201","message":"Created"}]'
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
end
