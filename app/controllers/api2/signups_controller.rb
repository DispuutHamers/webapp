#Class in responsible for handling calls to '/signups'
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
    signup = Signup.find(params[:id])
    update_by_owner_or_admin(signup, signup_params)
  end

  api :POST, '/signups', 'Create event'
  param :event_id, Integer, :required => true
  param :status, ["true","false"], :required => true
  def create
    event = do_signup(key.user)
    if event
      render :status => :created, :text => '{"status":"201","message":"Created"}'
    else
      render :status => :bad_request, :text => '{"status":"400","error":"Bad request"}'
    end
  end
end
