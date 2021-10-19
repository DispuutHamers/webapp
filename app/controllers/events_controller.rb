#entry point for events
class EventsController < ApplicationController
  require 'icalendar/tzinfo'
  before_action :ilid?, except: [:index]
  before_action :set_event, only: [:remind, :show, :edit, :update, :destroy]
  breadcrumb 'Activiteiten', :events_path

  # GET /events
  # GET /events.json
  def index
    respond_to do |current_request|
      current_request.html do
        ilid?
        @past_events = Event.past.order(date: :desc).paginate(page: params[:page])
        @upcoming_events = Event.upcoming.order(date: :asc)
      end

      current_request.ics do
        apikey = ApiKey.where(key: params[:key]).first
        if apikey&.user&.active?
          calendar = generate_calendar
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
    @unknown = User.leden_en_aspiranten.where.not(id: Signup.where(event_id: @event.id).select(:user_id))
    @unknown = @unknown.where(:id => @event.usergroup.users.all) if @event.usergroup

    breadcrumb @event.title, event_path(@event)
  end

  # GET /events/new
  def new
    @event = Event.new
    breadcrumb 'Nieuwe activiteit', :new_event_path
  end

  # GET /events/1/edit
  def edit
    breadcrumb @event.title, edit_event_path(@event)
  end

  # POST /events
  # POST /events.json
  def create
    event = Event.new(event_params)
    event.invitation_code = SecureRandom.uuid if event_params[:public] == "1"
    event.user_id = current_user.id
    save_object(event)
  end

  def remind
    if DateTime.now < @event.deadline
      unsigned_users = User.leden - @event.users
      unsigned_users.each { |user| UserMailer.mail_event_reminder(user, @event).deliver }
      flash[:success] = "Mail verzonden"
    else
      flash[:error] = "Mag niet"
    end

    redirect_to @event
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.invitation_code = SecureRandom.uuid if event_params[:public] == "1" && !@event.invitation_code
    @event.update(invitation_code: nil) if event_params[:public] == "0"
    update_object(@event, event_params)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    delete_object(@event)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find_by_id!(params[:id])
  end

  def generate_calendar
    feed = Event.upcoming.order('date')
    calendar = Icalendar::Calendar.new
    tzid = "Europe/Amsterdam"
    tz = TZInfo::Timezone.get tzid
    timezone = tz.ical_timezone feed.first.date
    calendar.add_timezone timezone
    feed.each do |feed_item|
      calendar.add_event(feed_item.to_ics)
    end

    User.active.each do |u|
      next unless u.birthday
      calendar.add_event(u.birthday_ics)
    end

    calendar
  end
end
