class Api2::EventsController < Api2::ApiController
	resource_description do
		api_versions '2.0'
		formats ['json']
		app_info 'De hamers api docs'
	end
	api :GET, '/events', 'Show event index'
	description 'Deze methode heeft een extra sorting op datum die kan worden aangeroepen door "?sorted=date" achter de URL te plakken.'
	example '[{"id":1,"beschrijving":"~2100 verjdaag vieren bij Rick","created_at":"2014-04-17T20:35:50.000+02:00","title":"Rick\'s Verjaardag","date":"2014-04-17T02:00:00.000+02:00","user_id":null,"deadline":null,"end_time":null,"location":null,"signups":"[{"id":1,"event_id":1,"user_id":1,"status":true,"created_at":"2014-04-18T17:00:52.000+02:00"}]"},{"id":2,"beschrijving":"Zondag borrel in de beiaard","created_at":"2014-04-18T01:45:12.000+02:00","title":"Zondag borrel","date":"2014-04-20T02:00:00.000+02:00","user_id":null,"deadline":null,"end_time":null,"location":null,"signups":"[{"id":3,"event_id":2,"user_id":1,"status":true,"created_at":"2014-04-18T17:01:18.000+02:00"},{"id":9,"event_id":2,"user_id":7,"status":true,"created_at":"2014-04-18T17:03:24.000+02:00"},{"id":19,"event_id":2,"user_id":2,"status":true,"created_at":"2014-04-18T22:04:59.000+02:00"},{"id":21,"event_id":2,"user_id":3,"status":true,"created_at":"2014-04-19T03:16:37.000+02:00"},{"id":22,"event_id":2,"user_id":8,"status":false,"created_at":"2014-04-19T19:15:13.000+02:00"}]"}]'
	def index 
		if params[:sorted] == 'date'
			render json: Event.all.order('date')
		elsif params[:sorted] == '-date'
			render json: Event.all.order('date').reverse_order
		else
			render json: Event.all
		end
	end

	api :GET, '/events/:id', 'Show event'
	param :id, :number
	def show
		render json: Event.find(params[:id])
	end

	api :UPDATE, '/events/:id', 'Update event'
	param :end_time, String, :required => true
	param :deadline, String, :required => true
	param :beschrijving, String, :required => true
	param :title, String, :required => true
	param :date, String, :required => true
	param :location, String
	def update
	  @event = Event.find(params[:id])
	 if @event.user_id != @key.user.id and !@key.user.admin?
	    render text: 'HTTP Token: Access denied.', status: :access_denied
	  elsif @event.update(event_params)
	    render json: @event
	  else
	    render json: @event.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/events', 'Create event'
	param :end_time, String, :required => true
	param :deadline, String, :required => true
	param :beschrijving, String, :required => true
	param :title, String, :required => true
	param :date, String, :required => true
	param :location, String
	def create
	  @event = Event.new(event_params)
	  @event.user_id = @key.user.id
	  if @event.save
	    update_app("{ data: { event: { id: \"#{@event.id}\", user_id: \"#{@event.user_id}\", beschrijving: \"#{@event.beschrijving}\", date: #{@event.date.to_json}, location: \"#{@event.location}\", deadline: #{@event.deadline.to_json}, signups: [], end_time: #{@event.end_time.to_json}, title: \"#{@event.title}\"} } }")
	    render json: @event, status: :created, location: @event
	  else
	    render json: @event.errors, status: :unprocessable_entity
	  end
	end
end
