# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
	runner "Event.new(beschrijving: \"Zondagborrel\", title: \"Zondagborrel\", date: Time.now + 1.weeks + 9.hours, deadline: Time.now + 1.weeks + 8.hours, end_time: Time.now + 1.weeks + 14.hours, location: \"Beiaard\").save"
end
