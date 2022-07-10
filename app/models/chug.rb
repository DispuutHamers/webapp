class Chug < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  belongs_to :chugtype
  belongs_to :user

  validates :chugtype, presence: true
  validates :user, presence: true
  validates :secs, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :milis, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }
  validates :comment, length: { maximum: 500 }
end
