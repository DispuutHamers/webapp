#entry point for meetings controller
class MeetingsController < ApplicationController
  before_action :logged_in?
  before_action :set_meeting, only: [:show, :notuleer, :edit, :update, :destroy]
  before_action :check_access
  before_action :admin_user?, only: [:notuleer,:destroy, :create, :new]

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
    meeting = Meeting.new(meeting_params)
    save_object(meeting, push=true)
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    @meeting.user_id = current_user.id if meeting_params[:notes]
    update_object(@meeting, meeting_params)
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    delete_object(@meeting)
  end

  private
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def check_access
    unless current_user.lid?
      redirect_to root_path
    end
  end
end
