#Responsible for handling calls to '/nicknames'
class Api2::NicknamesController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/nicknames', "Show nicknames"
  def index
    render json: Nickname.all
  end

  api :UPDATE, '/nicknames/:id', 'Update nickname'
  def update
    nickname = Nickname.find(params[:id])
    update_object(nickname, nickname_params)
  end

  api :POST, '/nicknames', 'Create nickname'
  def create
    nickname = Nickname.new(nickname_params)
    save_object(nickname)
  end
end
