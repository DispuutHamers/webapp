#entry point for meetings controller
class MeetingsController < ApplicationController
  before_action :lid?
  before_action :set_meeting, only: [:show, :notuleer, :edit, :update, :destroy]
  before_action :admin_user?, only: [:notuleer, :destroy, :create, :new]
  breadcrumb 'Vergaderingen', :meetings_path

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all.paginate(page: params[:page])
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @notulist = User.find_by(id: @meeting.user_id)
    breadcrumb @meeting.onderwerp, meeting_path(@meeting)
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
    breadcrumb 'Nieuwe vergadering', new_meeting_path
  end

  # GET /meetings/1/edit
  def edit
    breadcrumb @meeting.onderwerp, meeting_path(@meeting)
    breadcrumb 'Wijzig vergadering', edit_meeting_path(@meeting)
  end

  def notuleer
    if (draft = @meeting.drafts.where(user: current_user).take)
      @meeting.actiontext_notes = draft.rich_data
    end

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
    @meeting.actiontext_notes = meeting_params[:actiontext_notes]
    @meeting.user_id = current_user.id if meeting_params[:actiontext_notes]

    respond_to do |format|
      if params[:commit] == "Opslaan" && @meeting.save
        format.html { redirect_to @meeting, notice: 'Vergadering is geupdate.' }
      elsif params[:commit] == "Annuleren"
        @meeting.drafts.where(user: current_user).take.destroy
        format.html { redirect_to @meeting, notice: "Concept is verwijderd." }
      elsif @meeting.save_draft(current_user)
        format.js
      else
        format.html { render :edit }
        format.js { head :unprocessable_entity }
      end
    end
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
