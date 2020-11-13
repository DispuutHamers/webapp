class ExternalSignupsController < ApplicationController
  before_action :check_invitation_code
  before_action :event

  def new
    redirect_to event_path(@event), notice: "Je bent al ingelogd" if current_user
    @external_signup = ExternalSignup.new

    breadcrumb @event.title, @event.invitation_link
    breadcrumb "Schrijf je in", @event.invitation_link
  end

  def create
    @external_signup = @event.external_signups.create(external_signup_params)

    if @external_signup.persisted?
      redirect_to see_you_soon_event_path(invitation_code: @invitation_code)
    else
      render "external_signups/new"
    end
  end

  def see_you_soon
    respond_to do |current_request|
      current_request.html
      current_request.ics do
        render plain: calendar.to_ical
      end
    end
  end

  private

  def event
    @event ||= Event.find(params[:id])
  end

  def check_invitation_code
    return head :not_found unless event.invitation_code == params[:invitation_code]

    @invitation_code = params[:invitation_code]
  end

  def calendar
    calendar = Icalendar::Calendar.new
    tzid = "Europe/Amsterdam"
    tz = TZInfo::Timezone.get tzid
    timezone = tz.ical_timezone event.date
    calendar.add_timezone timezone
    calendar.add_event(event)

    calendar.publish
  end
end
