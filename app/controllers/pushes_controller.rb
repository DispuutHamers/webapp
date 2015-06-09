class PushesController < ApplicationController
	before_action :admin_user?

  # GET /pushes/new
  def new
    @push = Push.new
  end

  def create
    @push = Push.new(push_params)

		response = PUSH.send([@push.user.devices.first.device_key], @push.data)
		@push.user_id = current_user.id 

		@push.data = @push.data + " response was: " + response

    respond_to do |format|
      if @push.save
        format.html { redirect_to @push, notice: 'Push was successfully created.' }
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
