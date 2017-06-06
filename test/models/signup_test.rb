require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  test 'Signup should go correctly' do
    # create user 'u'
    u = users(:userone)

    # create event 'e'
    e = Event.create(title: 'Example event', end_time: '21:00',
                     date: DateTime.now + 50, deadline: DateTime.now + 5,
                     user_id: u.id)

    # signup user 'u' to event 'e'
    Signup.create(event_id: e.id, user_id: u.id)

    # assert user 'u' is signed up to event 'e'
    assert e.users[0].id == u.id

    # create second user 'u2'
    u2 = users(:usertwo)

    # signup user 'u2' to event 'e'
    Signup.create(event_id: e.id, user_id: u2.id)

    # assert both users are signed up to event 'e'
    assert e.signups[0].user_id == u.id
    assert e.signups[1].user_id == u2.id
  end

  test "User can't signup twice" do
    u = users(:userone)

    u2 = users(:usertwo)

    e = Event.create(title: 'Example event', end_time: '21:00',
                     date: DateTime.now + 50, deadline: DateTime.now + 5,
                     user_id: u.id)

    # signup user 'u' to event 'e'
    Signup.create(event_id: e.id, user_id: u.id)

    # assert user 'u' can't signup
    assert !Signup.create(event_id: e.id, user_id: u.id).save

    # assert user 'u2' can't signup (user 'u' created the event,
    #  might be seen differently)

    # signup user 'u2' to event 'e'
    Signup.create(event_id: e.id, user_id: u2.id)

    assert !Signup.create(event_id: e.id, user_id: u2.id).save
  end

  test "User can't signup after deadline" do
    u = users(:userone)

    e = Event.create(title: 'Example event', end_time: '21:00',
                     date: DateTime.now + 50, deadline: DateTime.now - 1,
                     user_id: u.id)

    assert !Signup.create(event_id: e.id, user_id: u.id).save
  end
end
