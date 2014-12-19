module ParamsHelper

	def review_params
		params.require(:review).permit(:user_id, :beer_id, :description, :rating, :proefdatum)
	end

	def micropost_params
		params.require(:quote).permit(:user_id, :text)
	end

end
