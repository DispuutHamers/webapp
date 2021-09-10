class ApiKeysController < ApplicationController
  before_action :ilid?
  before_action :correct_user?, only: [:show]

  def create
    ApiKey.create(user: current_user, name: api_key_params[:name])
    redirect_to request.referer
  end

  def show
    k = ApiKey.find_by_id!(params[:id])
    @rawkey = k.key

    breadcrumb current_user.name, user_path(current_user)
    breadcrumb 'API sleutels', edit_user_path(current_user)
    breadcrumb @rawkey, api_key_path(k)
  end

  def destroy
    key = ApiKey.find_by_id!(params[:id])
    delete_object(key)
  end

  private

  def correct_user?
    redirect_to root_url, notice: 'Niet genoeg access bitch' unless current_user == ApiKey.find_by_id!(params[:id]).user || current_user.admin?
  end
end
