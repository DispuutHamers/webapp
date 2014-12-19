module ParamsHelper

	def review_params
		params.require(:review).permit(:user_id, :beer_id, :description, :rating, :proefdatum)
	end

	def micropost_params
		params.require(:quote).permit(:user_id, :text)
	end

	def event_params
		params.require(:event).permit(:end_time, :deadline, :user_id, :bescrhijving, :title, :date)
	end

	def motion_params
		params.require(:motion).permit(:motion_type, :subject, :content)
	end
end
