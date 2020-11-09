#Responsible for sticking stickers
class Api2::StickersController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/stickers', 'Index stickers'
  def index
    render json: Sticker.all
  end

  api :GET, '/stickers/:id', 'Show sticker'
  def show
    render json: Sticker.find(params[:id])
  end

  api :POST, '/stickers', 'Create sticker'
  param :lat, String, :required => true
  param :lon, String, :required => true
  param :image, String
  param :notes, String
  def create
    sticker = Sticker.new(sticker_params)
    sticker.user_id = key.user.id
    save_object(sticker)
  end
end
