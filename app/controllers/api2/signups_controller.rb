class Api2::SignupsController < Api2::ApiController
	api :GET, '/signups/:id', 'Show signup'
	def show
	  render json: Signup.find(params[:id]).to_json
	end
    
	api :UPDATE, '/signups/:id', 'Update event'
	param :event_id, Integer, :required => true
	param :status, ["true","false"], :required => true
	def update
	  @signup = Signup.find(params[:id])
	  if @signup.update(signup_params)
	    render json: @signup
	  else
	    render json: @signup.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/signups', 'Create event'
	param :event_id, Integer, :required => true
	param :status, ["true","false"], :required => true
	def create
	  @signup = Signup.new(signup_params)
	  @signup.user_id = @key.user.id
	  if @signup.save
	    render json: @signup, status: :created, location: @signup
	  else
	    render json: @signup.errors, status: :unprocessable_entity
	  end
	end
end
