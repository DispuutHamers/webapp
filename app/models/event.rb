class Event < ActiveRecord::Base
  attr_accessor :public
  acts_as_paranoid
  has_paper_trail
  has_many :signups, dependent: :destroy
  has_many :signups_with_user, -> { with_user }, foreign_key: 'event_id', class_name: 'Signup'
  has_many :external_signups
  has_many :users, through: :signups
  has_rich_text :description
  belongs_to :user
  belongs_to :usergroup
  validates :title, presence: true, allow_blank: false
  validates :date, presence: true, allow_blank: false

  scope :with_signups, -> { includes(:signups) }
  scope :upcoming, -> { where(['date >= ?', Date.today]) }
  scope :past, -> { where(['date <= ?', Date.today]) }
  scope :are_public, -> { where.not(invitation_code: nil) }

  def to_ics
    url = "https://zondersikkel.nl/events/#{self.id}"
    event = Icalendar::Event.new
    event.dtstart = date.strftime('%Y%m%dT%H%M%S')
    event.dtend = end_time.strftime('%Y%m%dT%H%M%S')
    event.summary = title
    event.description = "#{description.to_plain_text} \n\n #{url}"
    event.location = location
    event.ip_class = 'PUBLIC'
    event.url = url
    event
  end

  def future?
    date.future?
  end

  def today?
    date.today?
  end

  def past?
    date.past?
  end

  def public?
    invitation_code.present?
  end

  def open?
    deadline != nil and deadline > Time.now
  end

  def invitation_link
    return unless invitation_code

    "/events/#{id}/public_signup?invitation_code=#{invitation_code}"
  end

  def attendee_count
    self.signups.count + self.external_signups.count
  end
end
