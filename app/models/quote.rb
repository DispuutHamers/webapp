class Quote < ActiveRecord::Base
  has_paper_trail ignore: %i[text]
  acts_as_paranoid
  belongs_to :user
  belongs_to :reporter, class_name: "User"
  validates :user, presence: true
  validates :reporter, presence: true
  validates :text, presence: true
  serialize :text

  encrypts :text

  scope :ordered, -> { order('created_at DESC') }
  scope :random, -> { order('RAND()') }
  scope :with_user, -> { includes(:user) }
end
