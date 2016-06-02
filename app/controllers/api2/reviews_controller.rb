class Api2::ReviewsController < Api2::ApiController
	#api :GET, '/reviews', "Show all reviews"
	api!
	api :GET, '/reviews', "Show review index"
	def index 
		json = ""
		Review.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/reviews/:id', "Show review"
	param :id, :number
	def show
		render json: Review.find(params[:id]).to_json
	end

	api :UPDATE, '/reviews/:id', 'Update review'
	param :id, :number
	def update
	end

	api :POST, '/reviews', 'Create review'
	def create
	end
end
