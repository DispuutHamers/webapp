class Event < ActiveRecord::Base
 has_many :signups, dependent: :destroy
 belongs_to :user

 def to_ics
	 event = Icalendar::Event.new
	 event.start = self.date.strftime("%Y%m%dT%H%M%S")
	 event.end = self.end_time.strftime("%Y%m%dT%H%M%S")
	 event.summary = self.title
	 event.description = self.beschrijving
	 event.location = 'Zonder Sikkel Secret Hideout Extreme 9000++'
	 event.klass = "PUBLIC"
	 event.created = self.created_at
	 event.last_modifed = self.updated_at
	 event.uit = event.url = "http://zondersikkel.nl/events/#{self.id}"
	 event
 end
end
