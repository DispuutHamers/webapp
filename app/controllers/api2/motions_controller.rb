class Api2::MotionsController < Api2::ApiController
	#api :GET, '/motions', "Show all motions"
	api!
	api :GET, '/motions', "Show motion index"
	def index 
		json = "["
		Motion.all.each do |b|
			json << b.to_json
			json << ","
		end
		json[json.length-1] = "]"
		render json: json
	end

	api :GET, '/motions/:id', "Show motion"
	def show
		render json: Motion.find(params[:id]).to_json
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
