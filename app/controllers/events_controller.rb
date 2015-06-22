class EventsController < ApplicationController
  include SessionsHelper
  before_action :logged_in?, only: [:edit, :update, :destroy]
  before_action :admin_user?, only: :destroy
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :edit]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order(date: :desc)
		respond_to do |w| 
			w.html do 
				@events = Event.all.order(date: :desc).paginate(page: params[:page])
        #redirect_to root_path, notice: "Mag niet!." unless lid?
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
			end
			w.ics do 
		    feed = Event.all.order("date").where(['date >= ?', Date.today]).limit(10)
				calendar = Icalendar::Calendar.new
				feed.each do |f|
					calendar.add_event(f.to_ics)
	      end
				calendar.publish
				render :text => calendar.to_ical
			end
		end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    respond_to do |format|
      if @event.save
				update_app("{ data: { event: { id: \"#{@event.id}\", user_id: \"#{@event.user_id}\", beschrijving: \"#{@event.beschrijving}\", date: \"#{@event.date.to_json}\", location: \"#{@event.location}\", deadline: \"#{@event.deadline}\", end_time: \"#{@event.end_time}\", title: \"#{@event.title}\"} } }")
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def correct_user
      @event.user == current_user
    end
end
