class Api2::UsersController < Api2::ApiController
	#api :GET, '/users', "Show all users"
	api!
	api :GET, '/users', "Show user index"
	def index 
		@User = User.all
	end

	api :GET, '/users/:id', "Show user"
	param :id, :number
	def show
		render text: User.find(params[:id]).to_json
	end

	api :UPDATE, '/users/:id', 'Update user'
	param :id, :number
	def update
	end

	api :POST, '/users', 'Create user'
	def create
	end
end
