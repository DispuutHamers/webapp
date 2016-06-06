class Api2::StickersController < Api2::ApiController
	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/stickers', 'Index stickers' 
	def index 
		json = "["
		Sticker.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end
	
	api :GET, '/stickers/:id', 'Show sticker' 
	def show
	  render json: Sticker.find(params[:id]).to_json
	end
  
	api :POST, '/stickers', 'Create sticker'
	param :lat, String, :required => true
	param :lon, String, :required => true
	param :notes, String
 	def create
	  @sticker = Sticker.new(sticker_params)
	  @sticker.user_id = @key.user.id
	  if @beer.save
	    render json: @sticker, status: :created, location: @sticker
	  else
	    render json: @sticker.errors, status: :unprocessable_entity
	  end
	end
end
