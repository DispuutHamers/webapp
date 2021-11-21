class Sticker < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  validates :lat, presence: true, format: { with: /\A(-?\d*\.\d*)\z/i, message: "Gast, dit is geen coördinaat"}
  validates :lon, presence: true, format: { with: /\A(-?\d*\.\d*)\z/i, message: "Gast, dit is geen coördinaat"}
end
