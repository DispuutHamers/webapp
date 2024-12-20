require 'google/apis/drive_v3'
require 'googleauth'

class DatabaseBackup < ApplicationJob
  queue_as :default

  def perform
    drive = Google::Apis::DriveV3::DriveService.new
    # TODO: Fix actual file path
    drive.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('google-drive-service-account-credentials.json'),
      scope: 'https://www.googleapis.com/auth/drive'
    )

    filename = "database_backup_#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}.sqllite3"
    database_file = Google::Apis::DriveV3::File.new(name: filename, parents: ['1fP9MXN2lhypkzaxIYyy7ZHb7e_M1jD5a'])
    # TODO: add correct source
    result = drive.create_file(database_file, upload_source: 'test.txt', supports_team_drives: true)
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
        if file.name.match?(/database_backup_(\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2})\.sqllite3/)
          date = Time.parse(Regexp.last_match(1))  # TODO parser fails
          if date < 0.days.ago
            puts "Deleting old backup #{file.name}"
            # TODO: drive.delete_file(file.id)
          end
        else
          puts "Skipping file #{file.name}"
        end
      end

      # Call check if backup was successful
      # TODO call check if backup was successful
      true
    else
      puts "Error uploading database backup"
      false
    end
  end
end
