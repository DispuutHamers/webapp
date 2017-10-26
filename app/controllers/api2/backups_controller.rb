#Responsible for making the database abailable to devs
class Api2::BackupsController < Api2::ApiController
  resource_description do
    api_versions "2.0"
    formats ['json']
    app_info "De hamers api docs"
  end

  api :GET, '/full_backup', "Get a full copy of the database, developer access on the website is required for this"
  def index
    if key.user.dev?
      dump = get_dump
      response.headers['Content-Type'] = 'text/plain'
      response.headers['Content-Disposition'] = 'attachment; filename=DATABASE_' + Date.today.to_s + '.bak'
      render plain: dump
    else
      render json: "Developer Access Level Required!"
    end
  end

  private

  def get_dump
    require Rails.root + 'lib/' + 'mysqldump.rb'
    Mysqldump.full_backup
  end
end
