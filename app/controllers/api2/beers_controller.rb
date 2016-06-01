class Api2::BeersController < Api2::ApiController
	#api :GET, '/beers', "Show all beers"
	api!
	api :GET, '/beers', "Show beer index"
	def index 
		@Beer = Beer.all
	end

	api :GET, '/beers/:id', "Show beer"
	param :id, :number
	def show
		render text: Beer.find(params[:id]).to_json
	end

	api :UPDATE, '/beers/:id', 'Update beer'
	param :id, :number
	def update
	end

	api :POST, '/beers', 'Create beer'
	def create
	end
end
