if @type == "user"
	json.array!(@result) do |user|
		json.extract! user, :id, :name, :email
		json.quotes user.quotes.count
		json.reviews user.reviews.count
		g_ids = []
		user.groups.each do |g|
			g_ids << Usergroup.find(g.group_id).name
		end
		json.in_groups g_ids
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
		json.extract! event, :id, :title, :beschrijving, :location, :deadline, :date, :user_id, :end_time
		json.signups(event.signups) do |signup|
			json.user_id signup.user_id
		  json.status	signup.status
		  json.created_at	signup.created_at
		end
	end
end
if @type == "beer"
	json.array!(@result) do |beer|
		json.extract! beer, :id, :name, :soort, :picture, :percentage, :brewer, :country, :URL 
		json.cijfer beer.cijfer?
	end
end
if @type == "review"
	json.array!(@result) do |review|
		json.extract! review, :beer_id, :user_id, :description, :rating, :created_at, :proefdatum
	end
end
if @type == "news" 
	json.array!(@result) do |news| 
		json.extract! news, :cat, :body, :title, :image, :date
	end
end
