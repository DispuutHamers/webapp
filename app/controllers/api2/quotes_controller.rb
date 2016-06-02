class Api2::QuotesController < Api2::ApiController
	#api :GET, '/quotes', "Show all quotes"
	api!
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
	param :id, :number
	def show
		render json: Quote.find(params[:id]).to_json
	end

	api :UPDATE, '/quotes/:id', 'Update quote'
	param :id, :number
	def update
	end

	api :POST, '/quotes', 'Create quote'
	def create
	end
end
