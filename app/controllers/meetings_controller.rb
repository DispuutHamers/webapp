#entry point for meetings controller
class MeetingsController < ApplicationController
  before_action :lid?
  before_action :set_meeting, only: [:show, :notuleer, :edit, :update, :destroy]
  before_action :admin_user?, only: [:notuleer, :destroy, :create, :new]
  breadcrumb 'Vergaderingen', :meetings_path

  def index
    @pagy, @meetings = pagy(Meeting.all, page: params[:page])
  end

  def show
    breadcrumb @meeting.onderwerp, meeting_path(@meeting)
  end

  def new
    @meeting = Meeting.new
    breadcrumb 'Nieuwe vergadering', new_meeting_path
  end

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

  def create
    meeting = Meeting.new(meeting_params)
    save_object(meeting)
  end

  def update
    respond_to do |format|
      if params[:commit] == "Opslaan"
        @meeting.actiontext_notes = meeting_params[:actiontext_notes]
        if @meeting.save
          format.html { redirect_to @meeting, notice: 'Vergadering is geüpdate.' }
        else
          render :edit
        end
      elsif params[:commit] == "Annuleren"
        @meeting.drafts.where(user: current_user).take&.destroy
        format.html { redirect_to @meeting, notice: "Concept is verwijderd." }
      elsif params[:commit] == "Verstuur"
        format.html do
          @meeting.attributes = meeting_params.except(:actiontext_notes)
          if @meeting.save
            redirect_to(@meeting, notice: 'Vergadering is geüpdate.')
          else
            render :edit
          end
        end
      elsif @meeting.save_draft(current_user)
        format.js
      else
        format.html { render :notuleer }
        format.js { head :unprocessable_entity }
      end
    end
  end

  def destroy
    delete_object(@meeting)
  end

  private

  def set_meeting
    @meeting = Meeting.includes(:chairman, :secretary).find(params[:id])
  end
end
