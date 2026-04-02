require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    @event = Event.create(title: 'Example event',
                          date: DateTime.now + 1.day,
                          end_time: DateTime.now + 1.day + 2.hours,
                          deadline: DateTime.now + 5,
                          user: users(:one))
  end

  test 'valid attendee count' do
    assert_equal 0, @event.attendee_count

    Signup.create(event: @event, user: users(:one))
    assert_equal 1, @event.attendee_count

    Signup.create(event: @event, user: users(:two))
    assert_equal 2, @event.attendee_count

    ExternalSignup.create(event: @event, user: users(:three),
                          first_name: "Test", last_name: "User", email: "test@example.com")
    assert_equal 3, @event.attendee_count

    ExternalSignup.create(event: @event, user: users(:two),
                          first_name: "Test", last_name: "User2", email: "test2@example.com")
    assert_equal 4, @event.attendee_count
  end

  test 'send_new_event_email always sends email to creator' do
    ActionMailer::Base.deliveries.clear
    @event.send_new_event_email
    creator_emails = ActionMailer::Base.deliveries.select { |m| m.to.include?(users(:one).email) }
    assert_not_empty creator_emails, "Creator should receive an email when they create an event"
  end

  test 'send_new_event_email sends email to creator even for attendance events' do
    attendance_event = Event.create(title: 'Dispuutsborrel',
                                    date: DateTime.now + 1.day,
                                    user: users(:one),
                                    attendance: true)
    ActionMailer::Base.deliveries.clear
    attendance_event.send_new_event_email
    creator_emails = ActionMailer::Base.deliveries.select { |m| m.to.include?(users(:one).email) }
    assert_not_empty creator_emails, "Creator should receive an email even for attendance events"
  end

  test 'send_new_event_email does not send duplicate email to creator when they have new_event_mail enabled' do
    users(:one).update!(new_event_mail: true)
    ActionMailer::Base.deliveries.clear
    @event.send_new_event_email
    creator_emails = ActionMailer::Base.deliveries.select { |m| m.to.include?(users(:one).email) }
    assert_equal 1, creator_emails.count, "Creator should receive exactly one email, not duplicates"
  end

end
