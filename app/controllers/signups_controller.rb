class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?, only: [:index, :edit, :update]
  before_action :logged_in?

  # GET /signups
  # GET /signups.json
  def index
    @signups = Signup.all
  end

  # GET /signups/1/edit
  def edit
  end

  # POST /signups
  # POST /signups.json
  def create
    @signup = Signup.new(signup_params)
    @event = Event.find(params[:signup][:event_id])
    if @event.deadline > Time.now
      current_user.sign!(@event, params[:signup][:status])
      flash[:success] = 'Je staat erbij!'
    else
      flash[:error] = 'De deadline is al verstreken'
    end
    redirect_to @event
  end

  # PATCH/PUT /signups/1
  # PATCH/PUT /signups/1.json
  def update
    respond_to do |format|
      if @signup.update(signup_params)
        format.html { redirect_to @signup, notice: 'Signup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    @signup.destroy
    respond_to do |format|
      format.html { redirect_to signups_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_signup
    @signup = Signup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def signup_params
    params.require(:signup).permit(:event_id, :user_id, :status, :reason)
  end
end
