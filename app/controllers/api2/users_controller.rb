class Api2::UsersController < Api2::ApiController
	#api :GET, '/users', "Show all users"
	api!
	api :GET, '/users', "Show user index"
	def index 
		json = "["
		User.all.each do |u|
			json << u.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/users/:id', "Show user"
	def show
		render json: User.find(params[:id]).to_json
	end

	api :GET, '/whoami', "Show current user" 
  def whoami
		render json: @key.user.to_json
	end
end
