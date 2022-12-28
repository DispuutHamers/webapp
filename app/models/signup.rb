class Signup < ActiveRecord::Base
  has_paper_trail on: [:update]
  acts_as_paranoid
  belongs_to :user
  belongs_to :event
  validates :user, uniqueness: { scope: [:user, :event] }, presence: true
  validates :event, presence: true
  validates :status, inclusion: { in: [true, false] }
  validate :event_deadline_has_passed
  attribute :status, :boolean, default: true

  # default_scope {includes(:user) }
  scope :with_user, -> { includes(:user) }

  private

  def event_deadline_has_passed
    return unless event&.deadline&.past?

    errors.add(:event_id, "Event deadline has already passed")
  end
end
