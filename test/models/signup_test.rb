require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  test "Signup should go correctly" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    e = Event.new
    e.title = "henk"
    e.end_time = "21:00"
    e.date = "2018-04-17T02:00:00.000+02:00"
    e.deadline = "2018-04-17T02:00:00.000+02:00"
    e.user_id = u.id
    e.save!

    s = Signup.new
    s.event_id = e.id
    s.user_id = u.id
    s.save!

    puts e.users
    puts ""
    assert e.users[0].id == u.id

    u2 = User.new
    u2.name = "Hamer tester 2"
    u2.email = "hamertester2@zondersikkel.nl"
    u2.password = "hamers"
    u2.save!

    s = Signup.new
    s.event_id = e.id
    s.user_id = u2.id
    s.save!

    assert e.signups[0].user_id == u.id
    assert e.signups[1].user_id == u2.id
 end
end
