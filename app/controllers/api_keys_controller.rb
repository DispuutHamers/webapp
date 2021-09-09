class ApiKeysController < ApplicationController
  before_action :ilid?
  before_action :user, only: [:index, :show]
  before_action :correct_user?, only: %i[show]

  def index
    breadcrumb 'Leden', :users_path
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb 'API-sleutels', user_api_keys_path(@user)

    render 'users/settings/api_keys'
  end

  def create
    current_user.generate_api_key(api_key_params[:name])
    redirect_to request.referer
  end

  def show
    k = ApiKey.find_by_id!(params[:id])
    @rawkey = k.key

    breadcrumb 'Leden', :users_path
    breadcrumb @user.name, user_path(@user)
    breadcrumb 'Update', edit_user_path(@user)
    breadcrumb 'API-sleutels', user_api_keys_path(@user)
    breadcrumb @rawkey, api_key_path(k)
  end

  def destroy
    key = ApiKey.find_by_id!(params[:id])
    delete_object(key)
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def correct_user?
    redirect_to root_url, notice: 'Niet genoeg access bitch' unless current_user == ApiKey.find_by_id!(params[:id]).user || current_user.admin?
  end
end
