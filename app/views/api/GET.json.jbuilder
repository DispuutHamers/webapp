if @type == "user"
	json.array!(@result) do |user|
		json.extract! user, :id, :name, :email
	end
end
if @type == "quote"
	json.array!(@result) do |quote|
		json.extract! quote, :id, :text, :user_id, :created_at
	end
end
if @type == "event"
	json.array!(@result) do |event|
		json.extract! event, :beschrijving, :title, :deadline, :date, :user_id, :end_time
	end
end
if @type == "beer"
	json.array!(@result) do |beer|
		json.extract! beer, :name, :soort, :picture, :percentage, :brewer, :country
	end
end
