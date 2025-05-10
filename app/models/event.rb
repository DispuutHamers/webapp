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
  validate :begin_before_end_time

  scope :with_signups, -> { includes(:signups) }
  scope :upcoming, -> { where(['(end_time IS NOT NULL AND end_time >= ?) OR date >= ?', Time.zone.now, Time.zone.now]) }
  scope :past, -> { where(['date <= ?', Time.zone.now]) }
  scope :are_public, -> { where.not(invitation_code: nil) }

  def to_ics
    url = "https://zondersikkel.nl/events/#{self.id}"
    event = Icalendar::Event.new
    event.dtstart = date.strftime('%Y%m%dT%H%M%S')
    if end_time.nil?
      # standard endtime is + one hour for activities, since an endtime has to be defined within an ics activity and not on our site
      event.dtend = (date + 1.hour).strftime('%Y%m%dT%H%M%S')
    else
      event.dtend = end_time.strftime('%Y%m%dT%H%M%S')
    end
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
    (deadline || date).future?
  end

  def can_be_deleted_by?(user)
    user == self.user || user.admin?
  end

  def invitation_link
    return unless invitation_code

    "/events/#{id}/public_signup?invitation_code=#{invitation_code}"
  end

  def attendee_count
    self.signups.count + self.external_signups.count
  end

  def send_new_event_email
    # Send new event to all leden who have new_event_email enabled
    if self.usergroup_id.nil?
      unless self.attendance # If not dispuutsborrel
        User.intern.where(new_event_mail: true).each { |user| UserMailer.mail_new_event(user, self).deliver }
      end
    else
      self.usergroup.users.where(new_event_mail: true).each { |user| UserMailer.mail_new_event(user, self).deliver }
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def to_s
    title
  end

  private

  def begin_before_end_time
    return unless date && end_time
    errors.add(:end_time, 'De activiteit eindigt voordat hij begint.') if date > end_time
  end
end
