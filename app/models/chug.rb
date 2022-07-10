class Chug < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  belongs_to :chugtype
  belongs_to :user
  belongs_to :reporter, class_name: "User"

  validates :chugtype, presence: true
  validates :user, presence: true
  validates :secs, presence: true, numericality: { greater_than: 0 }
  validates :milis, presence: true, numericality: { greater_than: 0, less_than: 1000 }
  validates :comment, length: { maximum: 500 }
end
