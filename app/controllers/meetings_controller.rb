class MeetingsController < ApplicationController
  before_action :logged_in?
  before_action :set_meeting, only: [:show, :notuleer, :edit, :update, :destroy]
  before_action :check_access
  before_action :admin_user?, only: [:notuleer, :edit, :update, :destroy, :create, :new]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all.paginate(page: params[:page])
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  def notuleer
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meeting }
      else
        format.html { render action: 'new' }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meeting_params
    params.require(:meeting).permit(:agenda, :notes, :onderwerp, :date, :user_id)
  end

  def check_access
    unless current_user.lid?
      redirect_to root_path
    end
  end
end
