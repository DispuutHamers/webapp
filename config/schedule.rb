set :chronic_options, hours24: true

every :wednesday, at: "1200" do
  runner 'UtilHelper.create_drink'
end

every :monday, at: "1900" do
  runner 'UtilHelper.remind_drink'
end

every :day, at: '0605' do
  runner 'UtilHelper.cleanup'
end
