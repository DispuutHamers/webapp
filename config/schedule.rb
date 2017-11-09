every :sunday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
  runner "Event.new(beschrijving: \"Tijdenlang heeft hier slechts het woord Zondagborrel gestaan, wat uiteraard de volledige dekking van dit wekelijks ritueel uitmuntent omschrijft, echter nieuwe tijden vragen om een nieuwe beschrijving. Daarom hetzelfde evenement maar nu met een langere omschrijving zodat idereen iets te lezen zal hebben terwijl `hun` dit grandiose event in spanning afwachten.\", attendance: true, title: \"Zondagborrel\", date: Time.now + 1.weeks + 9.hours, deadline: Time.now + 1.weeks + 8.hours, end_time: Time.now + 1.weeks + 14.hours, location: \"Beiaard Enschede\").save"
end

every :friday, :at => "7pm" do
  runner 'UtilHelper.remind_zondag'
end

every :day, :at => '6am' do
  runner 'User.all.each{ |u| u.update_weight }'
  runner 'Beer.all.each{ |b| b.update_cijfer }'
  runner "Blogitem.unscoped.where(\"title is NULL OR length(title) < 1\").delete_all"
end
