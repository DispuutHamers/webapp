require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @event = Event.create(title: 'Example event',
                          date: DateTime.now + 1.day,
                          end_time: DateTime.now + 1.day + 2.hours,
                          deadline: DateTime.now + 5,
                          user: @user)
    @signup = Signup.new(event: @event, user: @user)

    pp @event
  end

  test 'valid signup' do
    assert @signup.valid?
  end

  test 'valid absence signup' do
    @signup.status = false
    assert @signup.valid?
  end

  test 'valid signup with reason' do
    @signup.reason = "I will be there!"
    assert @signup.valid?
  end

  test 'invalid if signup for user+event already exists' do
    @signup.save

    second_signup = Signup.new(event: @event, user: @user)
    refute second_signup.valid?
  end

  test 'invalid if deadline is passed' do
    @event.deadline = DateTime.now - 1
    @event.save

    refute @signup.valid?
  end

  test 'invalid without user' do
    @signup.user = nil
    refute @signup.valid?
  end

  test 'invalid without event' do
    @signup.event = nil
    refute @signup.valid?
  end

  test 'invalid if user does not exist' do
    @signup.user_id = -1
    refute @signup.valid?
  end

  test 'invalid if event does not exist' do
    @signup.event_id = -1
    refute @signup.valid?
  end

  test 'invalid if signup has empty status' do
    @signup.status = nil
    refute @signup.valid?
  end
end
