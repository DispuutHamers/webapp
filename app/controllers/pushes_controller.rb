class PushesController < ApplicationController
  before_action :admin_user?

  def index
    @pushes = Push.order(created_at: :desc).paginate(page: params[:page], :per_page => 10)
  end

  # GET /pushes/new
  def new
    @push = Push.new
  end

  def create
    @push = Push.new(push_params)

    response = PUSH.send([@push.user.devices.first.device_key], eval(@push.data))
    @push.user_id = current_user.id

    respond_to do |format|
      if @push.save
        flash[:success] = 'Push succesvol aangemaakt.'
        format.html { redirect_to new_push_path }
        format.json { render action: 'show', status: :created, location: @push }
      else
        format.html { render action: 'new' }
        format.json { render json: @push.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def push_params
    params.require(:push).permit(:user_id, :data)
  end
end
