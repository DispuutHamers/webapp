class Api2::MeetingsController < Api2::ApiController
	#api :GET, '/meetings', "Show all meetings"
	api!
	api :GET, '/meetings', "Show meeting index"
	def index 
		@Meeting = Meeting.all
	end

	api :GET, '/meetings/:id', "Show meeting"
	param :id, :number
	def show
		render text: Meeting.find(params[:id]).to_json
	end

	api :UPDATE, '/meetings/:id', 'Update meeting'
	param :id, :number
	def update
	end

	api :POST, '/meetings', 'Create meeting'
	def create
	end
end
