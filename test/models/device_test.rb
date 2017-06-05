require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test 'Add device' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    old_count = Device.count

    assert Device.create(user_id: u.id).save

    assert Device.count == old_count + 1
  end
  test 'Device belongs to user' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    d = Device.create(user_id: u.id)
    d2 = Device.create(user_id: u.id)

    assert d.user_id == u.id
    assert d2.user_id == u.id
    assert u.devices[0].id == d.id
    assert u.devices[1].id == d2.id
  end

  test "Device doesn't belong to other user" do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    u2 = User.create(name: 'Hamer Tester 2',
                     email: 'testhamer2@zondersikkel.nl',
                     password: 'Hamers')

    d = Device.create(user_id: u.id)
    d2 = Device.create(user_id: u.id)

    assert d.user_id == u.id && d.user_id != u2.id
    assert d2.user_id == u2.id && d2.user_id != u.id
    assert u.devices[0].id == d.id
    assert u2.devices[0].id == d2.id
  end
end
