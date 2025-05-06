require 'google/apis/drive_v3'
require 'googleauth'

class DatabaseBackup < ApplicationJob
  queue_as :default

  def perform
    drive = Google::Apis::DriveV3::DriveService.new
    drive.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('config/credentials/google-drive.json'),
      scope: 'https://www.googleapis.com/auth/drive'
    )

    filename = "database_backup_#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}.sqlite3"
    database_file = Google::Apis::DriveV3::File.new(name: filename, parents: ['1fP9MXN2lhypkzaxIYyy7ZHb7e_M1jD5a'])
    result = drive.create_file(database_file, upload_source: 'db/production.sqlite3', supports_team_drives: true)
    if result.id
      puts "Database backup uploaded successfully"

      # delete files older than 60 days in Shared Drive 'Developers' -> 'database_backups'
      drive.list_files(
        drive_id: '0ADfPfTkhdOdoUk9PVA',
        q: "name contains 'database_backup_'",
        corpora: 'drive',
        include_items_from_all_drives: true,
        supports_team_drives: true,
      ).files.each do |file|
        puts "Checking file #{file.name}"
        if file.name.match?(/database_backup_(\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2})\.sqlite3/)
          date = Date.strptime(file.name, 'database_backup_%Y-%m-%d_%H:%M:%S.sqlite3')
          if date < (Time.now - 60.days)
            puts "Deleting old backup #{file.name}"
            drive.delete_file(file.id, supports_team_drives: true)
          end
        else
          puts "Skipping file #{file.name}"
        end
      end

      # Call check if backup was successful
      Net::HTTP.get(URI.parse('https://api.honeybadger.io/v1/check_in/xoIqO4'))
      true
    else
      puts "Error uploading database backup"
      false
    end
  end
end
