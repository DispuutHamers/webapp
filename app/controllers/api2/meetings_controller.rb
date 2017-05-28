#Responsible for handling calls to '/meetings' 
class Api2::MeetingsController < Api2::ApiController
  before_filter :restrict_to_admins, only: [:update, :post]
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/meetings', "Show meeting index"
  def index
    render json: Meeting.all
  end

  api :GET, '/meetings/:id', "Show meeting"
  def show
    render json: Meeting.find(params[:id])
  end

  api :UPDATE, '/meetings/:id', 'Update meeting'
  param :agenda, String
  param :notes, String
  param :onderwerp, String
  param :date, String
  def update
    meeting = Meeting.find(params[:id])
    meeting.user_id = key.user.id if meeting_params[:notes]
    update_object(meeting, meeting_params)
  end

  api :POST, '/meetings', 'Create meeting'
  param :agenda, String
  param :notes, String
  param :onderwerp, String
  param :date, String
  def create
    meeting = Meeting.new(meeting_params)
    meeting.user_id = key.user.id if meeting_params[:notes]
    save_object(meeting, push=true)
  end
end
