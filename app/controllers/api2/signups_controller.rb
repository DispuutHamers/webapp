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
    user = key.user.id
    existing_signups = Signup.where(user_id: user, event_id: signup_params[:event_id])
    if existing_signups.any?
      signup = existing_signups.first
      update_object(signup, signup_params)
    else
      signup = Signup.new(signup_params)
      signup.user_id = user
      save_object(signup)
    end
  end
end
