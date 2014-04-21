json.array!(@beers) do |beer|
  json.extract! beer, :id, :name, :soort
  json.url beer_url(beer, format: :json)
end
