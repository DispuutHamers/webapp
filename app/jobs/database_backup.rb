require 'google/apis/drive_v3'
require 'googleauth'
require 'stringio'

class DatabaseBackup < ApplicationJob
  queue_as :default

  def perform
    drive = Google::Apis::DriveV3::DriveService.new
    drive.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(Rails.application.credentials.google_drive_service_account.to_json),
      scope: 'https://www.googleapis.com/auth/drive'
    )

    filename = "database_backup_#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}.sqlite3"
    database_file = Google::Apis::DriveV3::File.new(name: filename, parents: ['1fP9MXN2lhypkzaxIYyy7ZHb7e_M1jD5a'])
    temp_file = "#{Rails.root}/tmp/#{filename}"
    system("tar -czf #{temp_file} -C #{Rails.root}/db .")
    result = drive.create_file(database_file, upload_source: temp_file, supports_team_drives: true)
    File.delete(temp_file) if File.exist?(temp_file)

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
        if file.name.match?(/database_backup_(\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2})\.tar.gz/)
          date = Date.strptime(file.name, 'database_backup_%Y-%m-%d_%H:%M:%S.tar.gz')
          if date < (Time.now - 90.days)
            puts "Deleting old backup #{file.name}"
            drive.delete_file(file.id, supports_team_drives: true)
          else
            puts "Keeping recent backup #{file.name}"
          end
        else
          puts "Filename does not match expected pattern: #{file.name}"
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
