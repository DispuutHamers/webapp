class Sticker < ActiveRecord::Base
  has_paper_trail
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  acts_as_paranoid
  validates :lat, presence: true
  validates :lon, presence: true
  def as_json(options)
    h = super({:only => [:id, :lat, :lon, :notes, :user_id]}.merge(options))
    h
  end
end
