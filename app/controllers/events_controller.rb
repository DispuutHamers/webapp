class EventsController < ApplicationController
  include SessionsHelper
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: :destroy
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :edit]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.order(date: :desc)
		respond_to do |w| 
			w.html do 
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
			end
			w.ics do 
		    feed = Event.find(:all, 
													 :order => "date", 
													 :conditions => ['date >= ?', Date.today], 
													 :limit => "10")
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
    
    def admin_user
      redirect_to root_url, notice: "Niet genoeg access bitch" unless (current_user.admin? || current_user.schrijf_feut?)
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
			params.require(:event).permit(:end_time, :deadline, :user_id, :beschrijving, :title, :date)
    end
end
