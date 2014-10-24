json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :agenda, :notes
  json.url meeting_url(meeting, format: :json)
end
