class Api2::SignupsController < Api2::ApiController
  	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/signups/:id', 'Show signup'
	def show
	  render json: Signup.find(params[:id])
	end
    
	api :UPDATE, '/signups/:id', 'Update event'
	param :event_id, Integer, :required => true
	param :status, ["true","false"], :required => true
	def update
	  @signup = Signup.find(params[:id])
	  if (@signupyy.user_id != @key.user.id and !@key.user.admin?)
	    render text: "HTTP Token: Access denied.", status: :access_denied
	  elsif @signup.update(signup_params)
	    render json: @signup
	  else
	    render json: @signup.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/signups', 'Create event'
	param :event_id, Integer, :required => true
	param :status, ["true","false"], :required => true
	def create
          if Signup.where(user_id: @key.user.id, event_id: signup_params[:event_id]).any?
            @signup = Signup.where(user_id: @key.user.id, event_id: signup_params[:event_id]).first
            @signup.update_attributes(signup_params)
            render json: @signup
            return
          end
	  @signup = Signup.new(signup_params)
	  @signup.user_id = @key.user.id
	  if @signup.save
	    render json: @signup, status: :created, location: @signup
	  else
	    render json: @signup.errors, status: :unprocessable_entity
	  end
	end
end
