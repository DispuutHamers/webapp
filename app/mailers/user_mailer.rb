# Sends emails to our users
class UserMailer < ApplicationMailer
  layout 'mailer', only: %i[mail_event_reminder]
  layout 'mail_new_event', only: %i[mail_new_event]
  layout 'reservation', only: %i[mail_reservation]

  def mail_event_reminder(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: "Doe eens inschrijven...")
  end

  def mail_reservation(event)
    @event = event
    mail(to: 'han@devluchte.nl', subject: "Hamers: #{event.signups.where(status: true).count} personen")
  end

  def mail_new_event(user, event)
    @event = event
    @user = user
    mail(to: user.email, subject: "Nieuwe activiteit: #{event.title}")
  end

  def mail_vluchte_bill(bill, user)
    @bill = bill
    @user = user
    mail(to: user.email, subject: "Vluchte rekening: #{bill.date.strftime('%d-%m-%Y')}")
  end
end
