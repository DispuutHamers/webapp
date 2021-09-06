class Signup < ActiveRecord::Base
  has_paper_trail on: [:update]
  acts_as_paranoid
  belongs_to :user
  belongs_to :event
  validates :user_id, uniqueness: {scope: :event_id}
  validate :event_deadline_has_passed
  attribute :status, :boolean, default: true

#  default_scope {includes(:user) }
  scope :with_user, -> { includes(:user) }

  private

  def event_deadline_has_passed
    return unless DateTime.now > Event.find(self.event_id).deadline

    errors.add(:event_id, "Event deadline has already passed")
  end
end
