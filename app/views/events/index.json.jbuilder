json.array!(@events) do |event|
  json.extract! event, :id, :beschrijving
  json.url event_url(event, format: :json)
end
