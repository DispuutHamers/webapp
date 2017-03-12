every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
	runner "Event.new(beschrijving: \"Zondagborrel\", attendance: true, title: \"Zondagborrel\", date: Time.now + 1.weeks + 9.hours, deadline: Time.now + 1.weeks + 8.hours, end_time: Time.now + 1.weeks + 14.hours, location: \"Beiaard Enschede\").save"
end

every :friday, :at => "7pm" do 
  runner 'UtilHelper.remind_zonder'
end

every :day, :at => '6am' do
        runner 'User.all.each{ |u| u.update_weight }'
	runner 'Beer.all.each{ |b| b.update_cijfer }'
end
