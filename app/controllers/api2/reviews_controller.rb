#Responsible for handling calls to '/reviews'
class Api2::ReviewsController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/reviews', "Show review index"
  def index
    render json: Review.all
  end

  api :GET, '/reviews/:id', "Show review"
  def show
    render json: Review.find(params[:id])
  end

  api :UPDATE, '/reviews/:id', 'Update review'
  param :beer_id, Integer, :required => true
  param :description, String, :required => true
  param :rating, [1,2,3,4,5,6,7,8,9,10], :required => true
  param :proefdatum, String
  def update
    review = Review.find(params[:id])
    update_by_owner_or_admin(review, review_params)
  end

  api :POST, '/reviews', 'Create review'
  param :beer_id, Integer, :required => true
  param :description, String, :required => true
  param :rating, [1,2,3,4,5,6,7,8,9,10], :required => true
  param :proefdatum, String
  def create
    review = Review.new(review_params)
    beer = Beer.find(params[:review][:beer_id])
    reviews = key.user.reviews.where(beer_id: beer.id)
    render json: beer, status: :unprocessable_entity and return if reviews.any?
    review.user_id = key.user.id
    review.proefdatum = Date.today unless review.proefdatum
    save_object(review, type = "review", push = true)
  end
end
