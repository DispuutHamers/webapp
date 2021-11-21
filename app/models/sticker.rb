class Sticker < ActiveRecord::Base
  has_paper_trail
  acts_as_paranoid
  belongs_to :user
  validates :lat, :lon, presence: true, format: { with: /\A(-?\d*\.\d*)\z/i, message: "Gast, dit is geen coördinaat" }

  def adres
    jdata = Net::HTTP.get_response(URI.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lon}&key=AIzaSyAz0ENeS5X1Vh9A_-KxxENHBf-qQYB2z-U"))
    mdata = JSON.parse(jdata.body)

    if mdata["results"] && mdata["results"][0] && mdata["results"][0]["formatted_address"]
      mdata["results"][0]["formatted_address"]
    else
      "Adres niet beschikbaar. Waarschijnlijk zijn de coordinaten misvormd."
    end
  end
end
