require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test 'Add device' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    old_count = Device.count

    d = Device.new
    d.user_id = u.id
    d.save!

    assert Device.count == old_count + 1
  end
  test 'Device belongs to user' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    d = Device.new
    d.user_id = u.id
    d.save!

    d2 = Device.new
    d2.user_id = u.id
    d2.save!

    assert d.user_id == u.id
    assert d2.user_id == u.id
    assert u.devices[0].id == d.id
    assert u.devices[1].id == d2.id
  end

  test "Device doesn't belong to other user" do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'testhamer@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    u2 = User.new
    u2.name = 'Hamer Tester 2'
    u2.email = 'testhamer2@zondersikkel.nl'
    u2.password = 'hamers'
    u2.save!

    d = Device.new
    d.user_id = u.id
    d.save!

    d2 = Device.new
    d2.user_id = u2.id
    d2.save!

    assert d.user_id == u.id and d.user_id != u2.id
    assert d2.user_id == u2.id and d2.user_id != u.id
    assert u.devices[0].id == d.id
    assert u2.devices[0].id == d2.id
  end
end
