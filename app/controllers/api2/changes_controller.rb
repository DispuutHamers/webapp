class Api2::ChangesController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/changes', "Show quote index"
  description '?since=<DateTime.parse slikt hier input>'
  def index
    since = DateTime.yesterday
    since = DateTime.parse(params[:since]) if params[:since]
    changes = PaperTrail::Version.where(created_at: since..DateTime.current).order(created_at: "DESC")
    render json: changes
  end
end
