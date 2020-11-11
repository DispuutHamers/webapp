class Quote < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :text, presence: true
  acts_as_paranoid
  serialize :text

  scope :with_user, -> { includes(:user) }
end
