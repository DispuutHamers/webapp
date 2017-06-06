require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test 'Add device' do
    u = users(:userone)

    old_count = Device.count

    assert Device.create(user_id: u.id).save
    assert_equal Device.count, old_count + 1
  end
  test 'Device belongs to user' do
    u = users(:userone)

    d = devices(:deviceone)
    d2 = devices(:devicetwo)

    assert d.user_id == u.id
    assert d2.user_id == u.id
    assert_equal u.devices[0].id, d.id
    assert_equal u.devices[1].id, d2.id
  end

  test "Device doesn't belong to other user" do
    u = users(:userone)

    u2 = users(:usertwo)

    d = devices(:deviceone)
    d3 = devices(:devicethree)

    assert d.user_id == u.id && d.user_id != u2.id
    assert d3.user_id == u2.id && d3.user_id != u.id
    assert_equal u.devices[0].id, d.id
    assert_equal u2.devices[0].id, d3.id
  end
end
