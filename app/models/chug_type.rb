class Chug_Type < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  belongs_to : chug
    validates :user, presence: true
  validates :reporter, presence: true
  validates :secs, presence: true
  validates :milis, presence: true
  validates :comment


  serialize :comment

  scope :ordered, -> { order('name DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }
end