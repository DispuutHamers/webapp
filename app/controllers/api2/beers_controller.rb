class Api2::BeersController < Api2::ApiController
	#api :GET, '/beers', "Show all beers"
	api!
	api :GET, '/beers', "Show beer index"
	example "[{"id":1,"name":"Jopen Laphroaig Barrel Aged","soort":"Russian Imperial Stout","created_at":"2014-04-22T00:19:57.000+02:00","picture":"http://res.cloudinary.com/ratebeer/image/upload/w_250,c_limit,q_85,d_beer_def.gif/beer_235785.jpg","percentage":"10.0%","brewer":"Jopen","country":"NL","URL":null,"cijfer":"8.73"},{"id":2,"name":"Snake Dog IPA","soort":"Indian Pale Ale","created_at":"2014-04-22T00:48:49.000+02:00","picture":"http://flyingdogbrewery.com/wp-content/uploads/2011/02/snake2013.png","percentage":"7.1%","brewer":"Flying Dog","country":"VS","URL":null,"cijfer":"7.45"}]"
	def index 
		json = "["
		Beer.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/beers/:id', "Show beer"
	param :id, :number
	def show
		render json: Beer.find(params[:id]).to_json
	end

	api :UPDATE, '/beers/:id', 'Update beer'
	param :id, :number
	def update
	end

	api :POST, '/beers', 'Create beer'
	def create
	end
end
