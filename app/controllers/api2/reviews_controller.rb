class Api2::ReviewsController < Api2::ApiController
  	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/reviews', "Show review index"
	def index 
		json = "["
		Review.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/reviews/:id', "Show review"
	def show
		render json: Review.find(params[:id]).to_json
	end

	api :UPDATE, '/reviews/:id', 'Update review'
	param :beer_id, Integer, :required => true
	param :description, String, :required => true
	param :rating, [1..10], :required => true
	param :proefdatum, DateTime
	def update
	  @review = Review.find(params[:id])
	  if @review.update(review_params)
	    render json: @review
	  else
    	    render json: @review.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/reviews', 'Create review'
	param :beer_id, Integer, :required => true
	param :description, String, :required => true
	param :rating, [1..10], :required => true
	param :proefdatum, DateTime
	def create
	  @review = Review.new(review_params)
	  @beer = Beer.find(params[:review][:beer_id]) # Nog nakijken voor injection
	  reviews = @key.user.reviews.where(beer_id: @beer.id)
	  render json: @beer, status: :unprocessable_entity and return if reviews.any?
	  @review.proefdatum = Date.today unless @review.proefdatum
	  if @review.save
            update_app("{ data: { review: { beer_id: \"#{@review.beer_id}\", user_id: \"#{@review.user_id}\", description: \"#{@review.description}\", rating: \"#{@review.rating}\", proefdatum: #{@review.proefdatum.to_json}, created_at: #{@review.created_at.to_json}} } }")
	    render json: @review, status: :created, location: @review
	  else
	    render json: @review.errors, status: :unprocessable_entity
	  end
	end
end
