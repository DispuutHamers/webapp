class ApiKeysController < ApplicationController
	before_action :logged_in?
	before_action :correct_user?, only: [:show]

  def create
		current_user.generate_api_key(api_key_params[:name])
		redirect_to request.referer
  end

	def show
		@key = RQRCode::QRCode.new(ApiKey.find(params[:id]).key).to_img.resize(200, 200).to_data_url
	end

	def destroy
		@key = ApiKey.find(params[:id])
		@key.destroy
		flash[:succes] = "Je api key is kaput"
		redirect_to request.referer
	end

	private
		def api_key_params
			params.require(:api_key).permit(:name)
		end 

		def correct_user? 
			redirect_to root_url, notice: "Niet genoeg access bitch" if current_user == ApiKey.find(params[:id]).user || admin_user?
		end
end
