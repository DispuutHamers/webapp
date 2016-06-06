class Api2::BeersController < Api2::ApiController
	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
  
	api :GET, '/beers', "Show beer index"
	example '[{"id":1,"name":"Jopen Laphroaig Barrel Aged","soort":"Russian Imperial Stout","created_at":"2014-04-22T00:19:57.000+02:00","picture":"http://res.cloudinary.com/ratebeer/image/upload/w_250,c_limit,q_85,d_beer_def.gif/beer_235785.jpg","percentage":"10.0%","brewer":"Jopen","country":"NL","URL":null,"cijfer":"8.73"},{"id":2,"name":"Snake Dog IPA","soort":"Indian Pale Ale","created_at":"2014-04-22T00:48:49.000+02:00","picture":"http://flyingdogbrewery.com/wp-content/uploads/2011/02/snake2013.png","percentage":"7.1%","brewer":"Flying Dog","country":"VS","URL":null,"cijfer":"7.45"}]'
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

	api :PATCH, '/beers/:id', 'Update beer'
	param :name, String, :required => true
	param :soort, String, :required => true
	param :picture, String
 	param :percentage, /\d?\d(\.\d)?/, :required => true
	param :country, String, :required => true
	param :brewer, String
	param :URL, String
	def update
	  @beer = Beer.find(params[:id])
	  if @beer.update(beer_params)
	    render json: @beer
	  else
	    render json: @beer.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/beers', 'Create beer'
	param :name, String, :required => true
	param :soort, String, :required => true
	param :picture, String
 	param :percentage, /\d?\d(\.\d)?/, :required => true
	param :country, String, :required => true
	param :brewer, String
	param :URL, String
	def create
	  @beer = Test.new(beer_params)
	  if @beer.save
	    update_app("{ data: { beer: { id: \"#{@beer.id}\", name: \"#{@beer.name}\", soort: \"#{@beer.soort}\", picture: \"#{@beer.picture}\", percentage: \"#{@beer.percentage}\", brewer: \"#{@beer.brewer}\", country: \"#{@beer.country}\", URL: \"#{@beer.URL}\", cijfer: \"null\", created_at: #{@beer.created_at.to_json}  } } }")
	    render json: @beer, status: :created, location: @beer
	  else
	    render json: @beer.errors, status: :unprocessable_entity
	  end
	end
end
