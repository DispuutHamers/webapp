class PicturesController < ApplicationController
  before_action :create_session
  breadcrumb 'Foto\'s', :pictures_path

  def index
    @files = @session.file_by_id('0B560gHNlIBG9NkFBWV9GMzV3U0E').subfolders
  end

  def folder
    folder = @session.file_by_id(params[:folder])
    @files = folder.files
    breadcrumb folder.title, :pictures_path
  end

  def image
     send_data(@session.file_by_id(params[:image]).download_to_string,
                           type: 'image/png',
                           disposition: 'inline')
  end

  private
  def create_session
    @session = GoogleDrive::Session.from_service_account_key(
      "google.json")
  end
end
