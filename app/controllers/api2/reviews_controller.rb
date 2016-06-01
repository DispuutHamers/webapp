class Api2::ReviewsController < Api2::ApiController
	#api :GET, '/reviews', "Show all reviews"
	api!
	api :GET, '/reviews', "Show review index"
	def index 
		@Review = Review.all
	end

	api :GET, '/reviews/:id', "Show review"
	param :id, :number
	def show
		render text: Review.find(params[:id]).to_json
	end

	api :UPDATE, '/reviews/:id', 'Update review'
	param :id, :number
	def update
	end

	api :POST, '/reviews', 'Create review'
	def create
	end
end
