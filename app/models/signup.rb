class Signup < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  belongs_to :event
  validates :user_id, uniqueness: {scope: :event_id}
  validate :event_deadline_has_passed

  def as_json(options)
    super({:only => [:id, :user_id, :event_id, :status, :created_at]}.merge(options))
  end
 
  private
  def event_deadline_has_passed
    errors.add(:event_id, "Event deadline has already passed") if 
      DateTime.now > Event.find(self.event_id).deadline
  end
end
