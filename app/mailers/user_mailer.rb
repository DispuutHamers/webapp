# Sends emails to our users
class UserMailer < ApplicationMailer
  layout 'mailer', only: %i[mail_event_reminder]

  def mail_event_reminder(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Doe eens inschrijven...")
  end
end
