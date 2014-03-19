json.array!(@afmeldingens) do |afmeldingen|
  json.extract! afmeldingen, :id, :reden, :user_id
  json.url afmeldingen_url(afmeldingen, format: :json)
end
