#generates a database dump
class DbdumpController < ApplicationController
  include SessionsHelper
  before_action :admin_user?

  def show
    require Rails.root + 'lib/' + 'mysqldump.rb'
    dump = Mysqldump.full_backup
    response.headers['Content-Type'] = 'text/plain'
    response.headers['Content-Disposition'] = 'attachment; filename=DATABASE_' + Date.today.to_s + '.bak'
    render :text => dump
  end
end
