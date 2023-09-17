class EventReminderEmail
  include Sidekiq::Job

  def perform(users, event)
    users.each do |user|
      UserMailer.mail_event_reminder(user, event).deliver
      sleep 15
    end
  end
end
