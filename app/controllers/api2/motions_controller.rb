class Api2::MotionsController < Api2::ApiController
	#api :GET, '/motions', "Show all motions"
	api!
	api :GET, '/motions', "Show motion index"
	def index 
		json = "["
		Motion.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/motions/:id', "Show motion"
	param :id, :number
	def show
		render json: Motion.find(params[:id]).to_json
	end

	api :UPDATE, '/motions/:id', 'Update motion'
	param :id, :number
	def update
	end

	api :POST, '/motions', 'Create motion'
	def create
	end
end
