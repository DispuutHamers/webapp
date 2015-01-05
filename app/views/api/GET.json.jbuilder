if @type == "user"
	json.array!(@result) do |user|
		json.extract! user, :id, :name, :email
		json.quotes user.quotes.count
		json.reviews user.reviews.count
	end
end
if @type == "quote"
	json.array!(@result) do |quote|
		json.extract! quote, :id, :text, :user_id, :created_at
	end
end
if @type == "signup"
	json.array!(@result) do |signup|
		json.extract! signup, :user_id, :event_id, :status, :created_at
	end
end
if @type == "event"
	json.array!(@result) do |event|
		json.extract! event, :id, :beschrijving, :title, :deadline, :date, :user_id, :end_time
		json.signups(event.signups) do |signup|
			json.user_id signup.user_id
		  json.status	signup.status
		  json.created_at	signup.created_at
		end
	end
end
if @type == "beer"
	json.array!(@result) do |beer|
		json.extract! beer, :id, :name, :soort, :picture, :percentage, :brewer, :country
	end
end
if @type == "review"
	json.array!(@result) do |review|
		json.extract! review, :beer_id, :user_id, :description, :rating, :created_at, :proefdatum
	end
end
