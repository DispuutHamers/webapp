class Api2::MeetingsController < Api2::ApiController
  	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/meetings', "Show meeting index"
	def index 
		render json: Meeting.all
	end

	api :GET, '/meetings/:id', "Show meeting"
	def show
		render json: Meeting.find(params[:id])
	end

	api :UPDATE, '/meetings/:id', 'Update meeting'
	param :agenda, String
	param :notes, String
	param :onderwerp, String
	param :date, DateTime
	def update
	  @meeting = Meeting.find(params[:id])
	  if @meeting.update(meeting_params)
	    render json: @meeting
	  else
	    render json: @meeting.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/meetings', 'Create meeting'
	param :agenda, String
	param :notes, String
	param :onderwerp, String
	param :date, DateTime
	def create
	  @meeting = Meeting.new(meeting_params)
	  if @meeting.save
	    render json: @meeting, status: :created, location: @meeting
	  else
	    render json: @meeting.errors, status: :unprocessable_entity
	  end
	end
end
