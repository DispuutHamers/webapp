class Api2::NewsController < Api2::ApiController
  	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/news', "Show news index"
	def index 
		json = "["
		News.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/news/:id', "Show news"
	def show
		render json: News.find(params[:id]).to_json
	end

	api :UPDATE, '/news/:id', 'Update news'
	param :cat, ['e', 'd', 'l'], :required => true	
	param :body, String, :required => true
	param :title, String, :required => true
	param :image, String
	def update
	  @news = News.find(params[:id])
	  if @news.update(news_params)
	    render json: @news
	  else
	    render json: @news.errors, status: :unprocessable_entity
	  end                             
	end

	api :POST, '/news', 'Create news'
	param :cat, ['e', 'd', 'l'], :required => true	
	param :body, String, :required => true
	param :title, String, :required => true
	param :image, String
	def create
	  @news = News.new(news_params)
	  @news.user_id = @key.user.id
	  @news.date = Time.now
	  if @news.save
	    render json: @news, status: :created, location: @news
	  else
	    render json: @news.errors, status: :unprocessable_entity
	  end
	end
end
