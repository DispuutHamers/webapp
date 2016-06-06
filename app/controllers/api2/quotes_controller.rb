class Api2::QuotesController < Api2::ApiController
  	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/quotes', "Show quote index"
	def index 
		json = "["		
		Quote.all.each do |q|
			json << q.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/quotes/:id', "Show quote"
	def show
		render json: Quote.find(params[:id]).to_json
	end

	api :UPDATE, '/quotes/:id', 'Update quote'
	param :user_id, Integer, :required => true
	param :text, String, :required => true
	def update
	  @quote = Quote.find(params[:id])
	  if @quote.update(micropost_params)
	    render json: @quote
	  else
	    render json: @quote.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/quotes', 'Create quote'
	param :user_id, Integer, :required => true
	param :text, String, :required => true
	def create
	  @quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
	  @quote.reporter = @key.user.id
	  if @quote.save
	    update_app("{ data: { quote: { id: \"#{@quote.id}\", user_id: \"#{@quote.user_id}\", text: \"#{@quote.text}\", created_at: #{@quote.created_at.to_json}} } }")
	    render json: @quote, status: :created, location: @quote
	  else
	    render json: @quote.errors, status: :unprocessable_entity
	  end
	end
end
