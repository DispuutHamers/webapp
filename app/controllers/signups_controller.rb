class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :edit, :update, :destroy]
  before_action :admin_user?, only: [:index, :edit, :update]
  before_action :ilid?

  def show
    redirect_to @signup.event
  end

  def create
    event = Event.find(signup_params[:event_id])
    current_user.signup(event, params[:commit] == "Aanwezig", signup_params[:reason])

    flash[:success] = 'Je staat erbij!'
    redirect_to event
  end

  def update
    update_by_owner_or_admin(@signup, signup_params)
  end

  def destroy
    delete_object(@signup)
  end

  private

  def set_signup
    @signup = Signup.find_by_id!(params[:id])
  end
end
