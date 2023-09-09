class EventReminderEmail
  include Sidekiq::Job

  def perform(users, event)
    users.each { |user| UserMailer.mail_event_reminder(user, event).deliver }
  end
end
