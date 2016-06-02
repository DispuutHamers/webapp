json.array!(@users) do |user|
  json.extract! user, :id, :name, :email
	json.lid "true" if user.lid? || user.alid?
	json.lid "false" unless user.lid? || user.alid?
  json.url user_url(user, format: :json)
end
