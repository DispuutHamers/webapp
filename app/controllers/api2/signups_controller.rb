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
    user = key.user
    event = Event.find(params[:signup][:event_id])
    if (event.deadline > Time.now and !!verify_signup(event))
      user.sign!(event, params[:signup][:status], params[:signup][:reason])
      render :status => :created, :text => '{"status":"201","message":"Created"}'
    else
      render :status => :bad_request, :text => '{"status":"400","error":"Bad request"}'
    end
  end

  private
  def verify_signup(event)
    if (event.attendance and "0" == params[:signup][:status])
      return params[:signup][:reason].length > 5
    else
      return true
    end
  end
end
