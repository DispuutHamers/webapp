class Sticker < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  validates :lat, presence: true
  validates :lon, presence: true
  def as_json(options)
    h = super({:only => [:id, :lat, :lon, :notes]}.merge(options))
    h
  end
end
