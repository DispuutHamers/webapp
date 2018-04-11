# manages push logging flow
class PushesController < ApplicationController
  before_action :admin_user?

  def index
    @pushes = Push.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
  end

  # GET /pushes/new
  def new
    @push = Push.new
  end

  def show
    redirect_to pushes_path
  end

  def create
    push = Push.new(push_params)
    if device_key = push.user.devices&.first&.device_key
      push.user_id = current_user.id
      save_object(push, type="push")
    end
  end
end
