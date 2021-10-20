class Attendee < ApplicationRecord
  belongs_to :meeting, inverse_of: :attendees
  belongs_to :user, inverse_of: :attendees

  validates :user_id, uniqueness: {scope: :meeting_id}

  scope :with_user, -> { includes(:user) }
end
