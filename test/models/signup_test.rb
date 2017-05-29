require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  test "Signup should go correctly" do
    # create user 'u'
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    # create event 'e'
    e = Event.new
    e.title = "Example event"
    e.end_time = "21:00"
    e.date = DateTime.now + 50  # 50 days in the future
    e.deadline = DateTime.now + 5  # 5 days in the future
    e.user_id = u.id
    e.save!

    # signup user 'u' to event 'e'
    s = Signup.new
    s.event_id = e.id
    s.user_id = u.id
    s.save!

    # assert user 'u' is signed up to event 'e'
    assert e.users[0].id == u.id

    # create second user 'u2'
    u2 = User.new
    u2.name = "Hamer tester 2"
    u2.email = "hamertester2@zondersikkel.nl"
    u2.password = "hamers"
    u2.save!

    # signup user 'u2' to event 'e'
    s = Signup.new
    s.event_id = e.id
    s.user_id = u2.id
    s.save!

    # assert both users are signed up to event 'e'
    assert e.signups[0].user_id == u.id
    assert e.signups[1].user_id == u2.id
  end

  test "User can't signup twice" do
    u = User.new
    u.name= "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    u2 = User.new
    u2.name= "Hamer Tester 2"
    u2.email = "hamertester2@zondersikkel.nl"
    u2.password = "hamers"
    u2.save!

    e = Event.new
    e.title = "Example event"
    e.end_time = "21:00"
    e.date = DateTime.now + 50  # 50 days in the future
    e.deadline = DateTime.now + 5  # 5 days in the future
    e.user_id = u.id
    e.save!

    # signup user 'u' to event 'e'
    s = Signup.new
    s.event_id = e.id
    s.user_id = u.id
    s.save!

    # assert user 'u' can't signup
    assert_raise do
      s = Signup.new
      s.event_id = e.id
      s.user_id = u.id
      s.save!
    end

    # assert user 'u2' can't signup (user 'u' created the event,
    #  might be seen differenty)
    
    # sinup user 'u2' to event 'e'
    s = Signup.new
    s.event_id = e.id
    s.user_id = u2.id
    s.save!

    assert_raise do
      s = Signup.new
      s.event_id = e.id
      s.user_id = u2.id
      s.save!
    end
  end

  test "User can't signup after deadline" do
    u = User.new
    u.name= "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    e = Event.new
    e.title = "Example event"
    e.end_time = "21:00"
    e.date = DateTime.now + 5  # 5 days in the future
    e.deadline = DateTime.now - 1  # 1 day in the past
    e.user_id = u.id
    e.save!

    assert_raise do
      begin
        s = Signup.new
        s.event_id = e.id
        s.user_id = u.id
        s.save!
      rescue Exception => e
        assert e.message == "Validatie mislukt: Event Event deadline has already passed"
	# raise e so assert_raise doesn't fail
        raise e
      end
    end
  end
end
