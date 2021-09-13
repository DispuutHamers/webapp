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
    assert_equal 0, @event.attendees

    Signup.create(event: @event, user: users(:one))
    assert_equal 1, @event.attendees

    Signup.create(event: @event, user: users(:two))
    assert_equal 2, @event.attendees

    ExternalSignup.create(event: @event, user: users(:three),
                          first_name: "Test", last_name: "User", email: "test@example.com")
    assert_equal 3, @event.attendees

    ExternalSignup.create(event: @event, user: users(:two),
                          first_name: "Test", last_name: "User2", email: "test2@example.com")
    assert_equal 4, @event.attendees
  end

end
