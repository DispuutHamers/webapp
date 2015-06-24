class ApiKeysController < ApplicationController
	before_action :logged_in?
	before_action :correct_user?, only: [:show]

  def create
		current_user.generate_api_key(api_key_params[:name])
		redirect_to request.referer
  end

	def show
		k = ApiKey.find(params[:id])
		@key = RQRCode::QRCode.new(k.key).to_img.resize(200, 200).to_data_url
		@logs = k.api_logs.paginate(page: params[:page], :per_page => 5)
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
			redirect_to root_url, notice: "Niet genoeg access bitch" unless current_user == ApiKey.find(params[:id]).user || current_user.admin?
		end
end
