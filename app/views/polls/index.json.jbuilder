json.array!(@polls) do |poll|
  json.extract! poll, :id, :beschrijving
  json.url poll_url(poll, format: :json)
end
