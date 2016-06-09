class Api2::MotionsController < Api2::ApiController
	before_action :restrict_to_admins, only: [:index, :show, :update]
 	resource_description do
		api_versions "2.0"
		formats ['json']
		app_info "De hamers api docs"
	end
	api :GET, '/motions', "Show motion index"
	def index 
		render json: Motion.all
	end

	api :GET, '/motions/:id', "Show motion"
	def show
		render json: Motion.find(params[:id])
	end

	api :UPDATE, '/motions/:id', 'Update motion'
	param :motion_type, ['niet chill', 'vet arelaxed', 'duurt lang'], :required => true
	param :subject, String, :required => true
	param :content, String, :required => true
	def update
	  @motion = Motion.find(params[:id])
	  if @motion.update(motion_params)
	    render json: @motion
	  else
	    render json: @motion.errors, status: :unprocessable_entity
	  end
	end

	api :POST, '/motions', 'Create motion'
	param :motion_type, ['niet chill', 'vet arelaxed', 'duurt lang'], :required => true
	param :subject, String, :required => true
	param :content, String, :required => true
	def create
	  @motion = Motion.new(meeting_params)
	  @motion.user_id = @key.user.id
	  if @motion.save
	    render json: @motion, status: :created, location: @motion
	  else
	    render json: @motion.errors, status: :unprocessable_entity
	  end
	end
end
