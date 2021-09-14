class Sticker < ActiveRecord::Base
  has_paper_trail
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_paranoid
  belongs_to :user
  validates :lat, presence: true, format: { with: /\A(-?\d*\.\d*)\z/i, message: "Gast, dit is geen coördinaat"}
  validates :lon, presence: true, format: { with: /\A(-?\d*\.\d*)\z/i, message: "Gast, dit is geen coördinaat"}
end
