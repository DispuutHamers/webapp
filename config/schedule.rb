every :monday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
  runner "Event.new(beschrijving: \"Maandag, wellicht de mooiste dag van de week. Voor sommigen de dag van God, maar voor ons voornamelijk de dag van bier! Na enkele weken onder de tyrannie van slecht gespelde evenementen is ook deze automatische uitnodiging danig ververst, dat het er fatsoenlijk uitziet. Wij moeten er ook fatsoenlijk uitzien, dus overhemd aan en naar de Vluchte!\", attendance: true, title: \"Maandagborrel\", date: Time.now + 1.weeks + 9.hours, deadline: Time.now + 6.days + 6.hours, end_time: Time.now + 1.weeks + 14.hours, location: \"De Vluchte Enschede\").save"
end

every :friday, :at => "7pm" do
  runner 'UtilHelper.remind_zondag'
end

every :sunday, :at => "7pm" do
  runner 'UtilHelper.make_reservation'
end

every :day, :at => '6am' do
  runner 'User.leden.each{ |u| UsersHelper.update_weight_for(u) }'
  runner 'User.leden.each{ |u| UsersHelper.sunday_ratio_for(u) }'
  runner 'Beer.all.each{ |b| b.update_cijfer }'
  runner "Blogitem.unscoped.where(\"title is NULL OR length(title) < 1\").delete_all"
end
