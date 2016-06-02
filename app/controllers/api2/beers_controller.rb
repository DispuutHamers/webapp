class Api2::BeersController < Api2::ApiController
	#api :GET, '/beers', "Show all beers"
	api!
	api :GET, '/beers', "Show beer index"
	def index 
		json = ""
		Beer.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/beers/:id', "Show beer"
	param :id, :number
	def show
		render json: Beer.find(params[:id]).to_json
	end

	api :UPDATE, '/beers/:id', 'Update beer'
	param :id, :number
	def update
	end

	api :POST, '/beers', 'Create beer'
	def create
	end
end
