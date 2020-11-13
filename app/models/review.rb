class Review < ActiveRecord::Base
  has_paper_trail
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, only_integer: true }
  validates :user, uniqueness: { scope: [:user, :beer]}
  belongs_to :user
  belongs_to :beer
  acts_as_paranoid

  scope :with_user, -> { includes(:user) }
end
