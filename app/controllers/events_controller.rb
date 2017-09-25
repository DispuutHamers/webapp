#entry point for events
class EventsController < ApplicationController
  require 'icalendar/tzinfo'
  before_action :logged_in?, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?, only: :destroy
  before_action :set_event, only: [:remind, :show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    respond_to do |current_request|
      current_request.html do
        redirect_to signin_url, notice: 'Please sign in.' unless signed_in?
        @events = Event.all.order(date: :desc).paginate(page: params[:page])
      end
      current_request.ics do
        apikey = ApiKey.where(key: params[:key]).first
        if apikey&.user&.lid?
          calendar = generate_calendar(apikey)
          calendar.publish
          render plain: calendar.to_ical
        else
          render plain: "HTTP Token: Access denied.", status: :access_denied
        end
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
    event = Event.new(event_params)
    event.user_id = current_user.id
    save_object(event, push=true)
  end

  def remind
    unless DateTime.now > @event.deadline
      unsigned_users = Usergroup.find_by(name: 'lid').users - @event.users
      unsigned_users.each { |user| UserMailer.mail_event_reminder(user, @event).deliver }
      flash[:success] = "Mail verzonden"
    else
      flash[:success] = "Mag niet"
    end
    redirect_to @event
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    update_by_owner_or_admin(@event, event_params)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    delete_object(@event)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def generate_calendar(key)
    ApiLog.new(key: key.key, user_id: key.user.id, ip_addr: request.remote_ip, resource_call: "Agenda sync").save
    feed = Event.all.order('date').where(['date >= ?', Date.today])
    calendar = Icalendar::Calendar.new
    tzid = "Europe/Amsterdam"
    tz = TZInfo::Timezone.get tzid
    timezone = tz.ical_timezone feed.first.date
    calendar.add_timezone timezone
    feed.each do |feed_item|
      calendar.add_event(feed_item.to_ics)
    end
    calendar
  end
end
