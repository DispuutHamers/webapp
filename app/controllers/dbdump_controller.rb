class DbdumpController < ApplicationController
	include SessionsHelper
	before_action :check_admin
  def show
		require Rails.root + "lib/" + "mysqldump.rb"
		dump = Mysqldump.full_backup
		response.headers['Content-Type'] = 'text/plain'
		response.headers['Content-Disposition'] = 'attachment; filename=DATABASE_' + Date.today.to_s + '.bak'
		render :text => dump 
  end
	private
		def check_admin
			redirect_to root_path unless current_user.admin?
		end
end
