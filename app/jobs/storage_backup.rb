require 'google/apis/drive_v3'
require 'googleauth'

class StorageBackup < ApplicationJob
  queue_as :default

  def perform
    drive = Google::Apis::DriveV3::DriveService.new
    drive.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open("#{Rails.root}/config/credentials/google-drive.json"),
      scope: 'https://www.googleapis.com/auth/drive'
    )

    filename = "storage_backup_#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}.tar.gz"
    storage_file = Google::Apis::DriveV3::File.new(name: filename, parents: ['1K8x_2ZMNa7J0nZtCLZ_PRY_GCODWmNx-'])
    temp_file = "#{Rails.root}/tmp/#{filename}"
    system("tar -czf #{temp_file} -C #{Rails.root}/storage .")
    result = drive.create_file(storage_file, upload_source: temp_file, supports_team_drives: true)
    File.delete(temp_file) if File.exist?(temp_file)

    if result.id
      puts "Storage backup uploaded successfully"

      # delete files older than 60 days in Shared Drive 'Developers' -> 'storage backups'
      drive.list_files(
        drive_id: '0ADfPfTkhdOdoUk9PVA',
        q: "name contains 'storage_backup_'",
        corpora: 'drive',
        include_items_from_all_drives: true,
        supports_team_drives: true,
        ).files.each do |file|
        puts "Checking file #{file.name}"
        if file.name.match?(/storage_backup_(\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2})\.sqlite3/)
          date = Date.strptime(file.name, 'storage_backup_%Y-%m-%d_%H:%M:%S.sqlite3')
          if date < (Time.now - 60.days)
            puts "Deleting old backup #{file.name}"
            drive.delete_file(file.id, supports_team_drives: true)
          end
        else
          puts "Skipping file #{file.name}"
        end
      end

      # Call check if backup was successful
      Net::HTTP.get(URI.parse('https://api.honeybadger.io/v1/check_in/b3Ije4'))
      true
    else
      puts "Error uploading storage backup"
      false
    end
  end
end
