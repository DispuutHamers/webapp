set :chronic_options, hours24: true
set :environment, ENV['RAILS_ENV']
set :bundle_command, 'bundle exec'
set :output, "#{Rails.root}/log/cron.log"
job_type :runner, "cd :path && :bundle_command rails runner -e :environment ':task' :output"

every :wednesday, at: '1200' do
  runner 'UtilHelper.create_drink'
end

every :monday, at: '1900' do
  runner 'UtilHelper.remind_drink'
end

every :week, at: '0605' do
  runner 'UtilHelper.cleanup'
end
