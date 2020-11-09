#handles calls to '/quotes'
class Api2::QuotesController < Api2::ApiController
  before_action :restrict_to_admins, only: [:update]
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/quotes', "Show quote index"
  description 'Deze methode heeft een extra sorting op datum die kan worden aangeroepen door "?sorted=date" achter de URL te plakken, of "?sorted=date-desc" om ze te sorteren met de nieuwste boven.'
  example 'Example: "GET /api/v2/quotes?sorted=date-desc" geeft
  [{"id": 987, "text": "In liefde kan je je piemel niet steken, in een kut wel.", "user_id": 14, "created_at": "2017-06-04T23:44:06.000+02:00" }, { "id": 986, "text": "Klein zijn is best handig als je ergens wil inbreken.", "user_id": 14, "created_at": "2017-06-04T22:31:44.000+02:00" }]'
  def index
    sorting = params[:sorted]
    quotes = Quote.all
    quotes = quotes.order('created_at') if sorting
    quotes = quotes.reverse_order if sorting == 'date-desc'
    render json: quotes
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
    save_object(quote)
  end
end
