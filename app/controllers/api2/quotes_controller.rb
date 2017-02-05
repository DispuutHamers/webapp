#handles calls to '/quotes'
class Api2::QuotesController < Api2::ApiController
  before_action :restrict_to_admins, only: [:update]
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/quotes', "Show quote index"
  def index
    render json: Quote.all
  end

  api :GET, '/quotes/:id', "Show quote"
  def show
    render json: Quote.find(params[:id])
  end

  api :UPDATE, '/quotes/:id', 'Update quote'
  param :user_id, Integer, :required => true
  param :text, String, :required => true
  def update
    quote = Quote.find(params[:id])
    update_by_owner_or_admin(quote, quote_params)
  end

  api :POST, '/quotes', 'Create quote'
  param :user_id, Integer, :required => true
  param :text, String, :required => true
  def create
    quote = User.find(micropost_params[:user_id]).quotes.build(micropost_params)
    quote.reporter = key.user.id
    save_object(quote, push = true)
  end
end
