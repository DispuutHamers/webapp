json.array!(@notes) do |note|
  json.extract! note, :id, :title, :content
  json.url note_url(note, format: :json)
end
