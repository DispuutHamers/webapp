# Sends emails to our users
class UserMailer < ApplicationMailer
  layout 'mailer', only: %i[mail_event_reminder]
  layout 'reservation', only: %i[mail_reservation]

  def mail_event_reminder(user, event, druif: false)
    @user = user
    @event = event
    @druif = druif  
    @subject = druif ? "Doe eens inschrijven, deze mail geldt dus ook voor jou #{user.name}" : "Doe eens inschrijven" 
    mail(to: @user.email, subject: @subject)

  end

  def mail_reservation(event)
    @event = event
    mail(to: 'han@devluchte.nl', subject: "Hamers: #{event.signups.where(status: true).count} personen")
  end

end
