class Sticker < ActiveRecord::Base
  has_paper_trail
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  acts_as_paranoid
  validates :lat, presence: true
  validates :lon, presence: true
  def as_json(options)
    h = super({:only => [:id, :lat, :lon, :notes, :user_id]}.merge(options))
    h
  end
end
