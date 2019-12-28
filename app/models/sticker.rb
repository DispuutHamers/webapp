class Sticker < ActiveRecord::Base
  has_paper_trail
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_paranoid
  validates :lat, presence: true, format: { with: /(\d*\.\d*)/i, message: "Gast, dit is geen coördinaat"}
  validates :lon, presence: true, format: { with: /(\d*\.\d*)/i, message: "Gast, dit is geen coördinaat"}
  def as_json(options)
    super({ only: %i[id lat lon notes user_id] }.merge(options))
  end
end
