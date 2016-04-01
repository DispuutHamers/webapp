class Review < ActiveRecord::Base
  validates :rating, presence: true
  belongs_to :user
  belongs_to :beer
end
