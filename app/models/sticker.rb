class Sticker < ActiveRecord::Base
  def as_json(options)
    h = super({:only => [:id, :lat, :lon, :notes}.merge(options))
    h
  end
end
