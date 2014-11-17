class Event < ActiveRecord::Base
 has_many :signups, dependent: :destroy
 belongs_to :user

 def to_ics
	 event = Icalendar::Event.new
	 event.dtstart = date.advance(:hours => -1).strftime("%Y%m%dT%H%M%S")
	 event.dtend = end_time.advance(:hours => -1).strftime("%Y%m%dT%H%M%S")
	 event.summary = title
	 event.description = beschrijving
	 event.location = 'Zonder Sikkel Secret Hideout Extreme 9000++'
	 event.ip_class = "PUBLIC"
	 event.url = "http://zondersikkel.nl/events/#{self.id}"
	 event
 end
end
