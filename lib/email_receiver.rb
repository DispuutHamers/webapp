class EmailReceiver < Incoming::Strategies::HTTPPost
	setup :secret => '6d7e5337a0cd69f52c3fcf9f5af438b1'

	def receive(mail)
		@mail = Email.new.to(mail.to.first, body: mail.subject)
		@mail.save
	end
end

req = Rack::Request.new(env)
result = EmailReceiver.receive(req) # => Got message from whoever@wherever.com with subject "hello world"
