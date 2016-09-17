class Endpoints::EmailController < ApplicationController
	setup :secret => '6d7e5337a0cd69f52c3fcf9f5af438b1'
	
	def receive
		%(Got message from #{mail.to.first} with subject "#{mail.subject}")
	end
end
