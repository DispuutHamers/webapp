#entry point for meetings controller
class MeetingsController < ApplicationController
  before_action :lid?
  before_action :set_meeting, only: [:show, :notuleer, :edit, :update, :destroy]
  before_action :admin_user?, only: [:notuleer,:destroy, :create, :new]
  breadcrumb 'Vergaderingen', :meetings_path


  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all.paginate(page: params[:page])
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    breadcrumb @meeting.onderwerp, meeting_path(@meeting)
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    breadcrumb 'Nieuwe Vergadering', new_meeting_path
  end

  # GET /meetings/1/edit
  def edit
  end

  def notuleer
    breadcrumb @meeting.onderwerp, meeting_path(@meeting)
    breadcrumb 'Notuleren', "/notuleer/#{@meeting.id}"
  end

  # POST /meetings
  # POST /meetings.json
  def create
    meeting = Meeting.new(meeting_params)
    save_object(meeting)
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
end
