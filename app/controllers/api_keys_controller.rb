class ApiKeysController < ApplicationController
	before_action :logged_in?

  def create
		current_user.generate_api_key(api_key_params[:name])
		redirect_to request.referer
  end

	private
		def api_key_params
			params.require(:api_key).permit(:name)
		end 
end
