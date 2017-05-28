# Sends emails to our users
class UserMailer < ApplicationMailer

  def mail_event_reminder(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Doe eens inschrijven...")
  end

end
