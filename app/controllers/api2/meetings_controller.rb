class Api2::MeetingsController < Api2::ApiController
	#api :GET, '/meetings', "Show all meetings"
	api!
	api :GET, '/meetings', "Show meeting index"
	def index 
		json = "["
		Meeting.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/meetings/:id', "Show meeting"
	param :id, :number
	def show
		render json: Meeting.find(params[:id]).to_json
	end

	api :UPDATE, '/meetings/:id', 'Update meeting'
	param :id, :number
	def update
	end

	api :POST, '/meetings', 'Create meeting'
	def create
	end
end
