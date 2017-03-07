class Api2::ChangesController < Api2::ApiController
  def index
    since = DateTime.yesterday
    since = DateTime.parse(params[:since]) if params[:since]
    changes = PaperTrail::Version.where(created_at: since..DateTime.current).order(created_at: "DESC")
    render json: changes
  end
end
