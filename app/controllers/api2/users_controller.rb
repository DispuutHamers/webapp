#Endpoint for user resource
class Api2::UsersController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/users', "Show user index"
  def index
    render json: User.all
  end

  api :GET, '/users/:id', "Show user"
  def show
    render json: User.find(params[:id])
  end

  api :GET, '/whoami', "Show current user"
  def whoami
    render json: key.user
  end
end
