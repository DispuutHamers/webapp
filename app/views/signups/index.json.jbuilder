json.array!(@signups) do |signup|
  json.extract! signup, :id, :event_id, :user_id, :status, :reason
  json.url signup_url(signup, format: :json)
end
