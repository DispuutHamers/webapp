class Event < ActiveRecord::Base
 has_many :signups, dependent: :destroy
 belongs_to :user

 def to_ics
	 event = Icalendar::Event.new
	 event.dtstart = date.advance(:hours => -2).strftime("%Y%m%dT%H%M%S")
	 event.dtend = end_time.advance(:hours => -2).strftime("%Y%m%dT%H%M%S")
	 event.summary = title
	 event.description = beschrijving
	 event.location = location
	 event.ip_class = "PUBLIC"
	 event.url = "http://zondersikkel.nl/events/#{self.id}"
	 event
 end

 def future?
	 self.date.future?
 end

 def today? 
	 self.date.today?
 end

 def past?
	 !self.date.future?
 end
end
