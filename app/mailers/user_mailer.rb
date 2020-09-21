# Sends emails to our users
class UserMailer < ApplicationMailer
  layout 'mailer', only: %i[mail_event_reminder]
  layout 'reservation', only: %i[mail_reservation]

  def mail_event_reminder(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Doe eens inschrijven...")
  end

  def mail_event_reminder_druif(user, event, druif: false)
    @user = user
  @druif = druif  
  @subject = druif ? "subject voor druif" : "subject voor rest" 
  mail(to: @user.email, subject: "Doe eens inschrijven, deze mail geldt dus ook voor jouw #{user.name}", druif)
  end

  def mail_reservation(event)
    @event = event
    mail(to: 'han@devluchte.nl', subject: "Hamers: #{event.signups.where(status: true).count} personen")
  end

end
