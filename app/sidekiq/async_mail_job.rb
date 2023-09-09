class AsyncMailJob
  include Sidekiq::Job

  def perform(user_mailer_method, email_addresses, *args)
    email_addresses.each do |email_address|
      puts "Sending email to #{email_address}"
      # user_mailer_method(*args).deliver
    end
  end
end
