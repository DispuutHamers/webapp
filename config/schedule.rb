require 'net/http'
require 'uri'

set :chronic_options, hours24: true

every :wednesday, at: "1200" do
  date = "Time.now + 1.weeks + 9.hours" # Next wednesday, 21:00h
  end_time = "Time.now + 1.weeks + 14.hours" # Next thursday, 02:00h
  deadline = "Time.now + 1.weeks + 6.hours" # Next wednesday, 18:00h
  runner "Event.new(description: \"Woensdag, wellicht de mooiste dag van de week. Voor sommigen de dag van God, maar voor ons voornamelijk de dag van bier! Na enkele weken onder de tyrannie van slecht gespelde evenementen is ook deze automatische uitnodiging danig ververst, dat het er fatsoenlijk uitziet. Wij moeten er ook fatsoenlijk uitzien, dus overhemd aan en naar de Vluchte!\",
                    attendance: true, title: \"Dispuutsborrel\",
                    date: #{date},
                    end_time: #{end_time},
                    deadline: #{deadline},
                    location: \"De Vluchte\"
                   ).save"

  # Ping healthchecks.io for monitoring purposes
  runner "Net::HTTP.get(URI.parse('https://hc-ping.com/fffa8b9f-1d79-4e3b-89a3-1f704c145138'))"
end

every :tuesday, at: "1900" do
  runner 'UtilHelper.remind_drink'

  # Ping healthchecks.io for monitoring purposes
  runner "Net::HTTP.get(URI.parse('https://hc-ping.com/fed0752c-e524-4af6-907e-23bd47336eb9'))"
end

every :day, at: '0605' do
  runner 'User.leden.each{ |u| UsersHelper.update_weight_for(u) }'
  runner 'User.leden.each{ |u| UsersHelper.sunday_ratio_for(u) }'
  runner 'Beer.all.each{ |b| b.update_cijfer }'
  runner "Blogitem.unscoped.where(\"title is NULL OR length(title) < 1\").delete_all"

  # Ping healthchecks.io for monitoring purposes
  runner "Net::HTTP.get(URI.parse('https://hc-ping.com/3a65b459-ea8f-4f0c-89ce-c8f1b750c5fb'))"
end
