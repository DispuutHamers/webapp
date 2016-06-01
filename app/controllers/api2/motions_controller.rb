class Api2::MotionsController < Api2::ApiController
	#api :GET, '/motions', "Show all motions"
	api!
	api :GET, '/motions', "Show motion index"
	def index 
		@Motion = Motion.all
	end

	api :GET, '/motions/:id', "Show motion"
	param :id, :number
	def show
		render text: Motion.find(params[:id]).to_json
	end

	api :UPDATE, '/motions/:id', 'Update motion'
	param :id, :number
	def update
	end

	api :POST, '/motions', 'Create motion'
	def create
	end
end
