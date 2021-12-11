class Sticker < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  validates :lat, :lon, presence: true, format: { with: /\A(-?\d*\.\d*)\z/i, message: "Gast, dit is geen coördinaat" }
  before_save :store_address

  def store_address
    self.address = resolve_address
  end

  private

  def resolve_address
    jdata = Net::HTTP.get_response(URI.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lon}&key=#{Rails.application.secrets.google_api_key}"))
    mdata = JSON.parse(jdata.body)

    if mdata["results"] && mdata["results"][0] && mdata["results"][0]["formatted_address"]
      mdata["results"][0]["formatted_address"]
    else
      "Adres niet beschikbaar. Waarschijnlijk zijn de coordinaten misvormd."
    end
  end
end
