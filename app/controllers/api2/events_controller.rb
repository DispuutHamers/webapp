class Api2::EventsController < Api2::ApiController
	#api :GET, '/events', "Show all events"
	api!
	api :GET, '/events', "Show event index"
	def index 
		@Event = Event.all
	end

	api :GET, '/events/:id', "Show event"
	param :id, :number
	def show
		render text: Event.find(params[:id]).to_json
	end

	api :UPDATE, '/events/:id', 'Update event'
	param :id, :number
	def update
	end

	api :POST, '/events', 'Create event'
	def create
	end
end
