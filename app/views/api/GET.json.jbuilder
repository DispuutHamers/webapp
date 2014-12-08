if @type == "user"
	json.array!(@result) do |user|
		json.extract! user, :id, :name, :email
		json.url user_url(user, format: :json)
	end
end
if @type == "quote"
	json.array!(@result) do |quote|
		json.extract! quote, :id, :text, :user_id, :created_at
	end
end
