class Event < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  has_many :signups, dependent: :destroy
  has_many :signups_with_user, -> { with_user }, foreign_key: 'event_id', class_name: 'Signup'
  has_many :users, through: :signups
  has_rich_text :description
  belongs_to :user

#  default_scope {includes(:signups)}
  scope :with_signups, -> { includes(:signups) }
  scope :upcoming, -> { where(['date >= ?', Date.today]) }
  scope :past, -> { where(['date <= ?', Date.today]) }

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = date.strftime('%Y%m%dT%H%M%S')
    event.dtend = end_time.strftime('%Y%m%dT%H%M%S')
    event.summary = title
    event.description = description.to_plain_text || beschrijving
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
    h = super({:only => [:id, :attendance, :title, :beschrijving, :description, :location, :deadline, :date, :user_id, :end_time, :created_at]}.merge(options))
    h[:signups] = signups.as_json(options)
    h
  end
end
