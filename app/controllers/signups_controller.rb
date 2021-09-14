# Signups controller
class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?, only: [:index, :edit, :update]
  before_action :ilid?

  def show
    redirect_to @signup.event
  end

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
    event = Event.find(signup_params[:event_id])
    current_user.signup(event, params[:commit] == "Aanwezig", signup_params[:reason])

    flash[:success] = 'Je staat erbij!'
    redirect_to event
  end

  # PATCH/PUT /signups/1
  # PATCH/PUT /signups/1.json
  def update
    update_by_owner_or_admin(@signup, signup_params)
  end

  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    delete_object(@signup)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_signup
    @signup = Signup.find_by_id!(params[:id])
  end
end
