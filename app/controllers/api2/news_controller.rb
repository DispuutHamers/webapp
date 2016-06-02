class Api2::NewsController < Api2::ApiController
	#api :GET, '/news', "Show all news"
	api!
	api :GET, '/news', "Show news index"
	def index 
		json = ""
		News.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/news/:id', "Show news"
	param :id, :number
	def show
		render json: News.find(params[:id]).to_json
	end

	api :UPDATE, '/news/:id', 'Update news'
	param :id, :number
	def update
	end

	api :POST, '/news', 'Create news'
	def create
	end
end
