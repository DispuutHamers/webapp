class Event < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  has_many :signups, dependent: :destroy
  belongs_to :user

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = date.strftime('%Y%m%dT%H%M%S')
    event.dtend = end_time.strftime('%Y%m%dT%H%M%S')
    event.summary = title
    event.description = beschrijving
    event.location = location
    event.ip_class = 'PUBLIC'
    event.url = "http://zondersikkel.nl/events/#{self.id}"
    event
  end

  def future?
    self.date.future?
  end

  def today?
    self.date.today?
  end

  def past?
    !self.date.future?
  end

  def as_json(options)
    h = super({:only => [:id, :title, :beschrijving, :location, :deadline, :date, :user_id, :end_time, :created_at]}.merge(options))
    h[:signups] = signups.as_json(options)
    h
  end
end
