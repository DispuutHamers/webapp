class ApiKeysController < ApplicationController
  before_action :ilid?
  before_action :user, only: :index
  before_action :correct_user?, only: %i[show]

  def index
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb 'API keys', user_api_keys_path(@user)

    render 'users/settings/api_keys'
  end

  def create
    current_user.generate_api_key(api_key_params[:name])
    redirect_to request.referer
  end

  def show
    breadcrumb current_user.name, user_path(current_user)
    breadcrumb 'API-sleutels', edit_user_path(current_user)
    breadcrumb @rawkey, api_key_path(k)

    k = ApiKey.find(params[:id])
    @rawkey = k.key
  end

  def destroy
    key = ApiKey.find(params[:id])
    delete_object(key)
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def correct_user?
    redirect_to root_url, notice: 'Niet genoeg access bitch' unless current_user == ApiKey.find(params[:id]).user || current_user.admin?
  end
end
