class Chug < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  validates :user, presence: true
  validates :reporter, presence: true
  validates :secs, presence: true
  validates :milis, presence: true
  serialize :comment

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }
end