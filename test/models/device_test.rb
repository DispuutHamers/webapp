require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test 'Add device' do
    u = users(:one)

    old_count = Device.count

    assert Device.create(user_id: u.id).save
    assert_equal Device.count, old_count + 1
  end
  test 'Device belongs to user' do
    u = users(:one)

    d = devices(:one)
    d2 = devices(:two)

    assert d.user_id == u.id
    assert d2.user_id == u.id
    # assert_includes, of assert dat [0]==d.id? dan moet je namelijk met volgorde gaan kutten
    assert_includes u.devices, d
    assert_includes u.devices, d2
    # assert_equal u.devices[1].id, d.id
    # assert_equal u.devices[0].id, d2.id
  end

  test "Device doesn't belong to other user" do
    u = users(:one)

    u2 = users(:two)

    d = devices(:one)
    # three because device three is linked to user 2 (device two is linked to user one as well)
    d3 = devices(:three)

    assert d.user_id == u.id && d.user_id != u2.id
    assert d3.user_id == u2.id && d3.user_id != u.id
    # user 1 has two devices (phone and laptop - see fixtures/devices.yml, so get the 2nd item in list
    assert_equal u.devices[1].id, d.id
    assert_equal u2.devices[0].id, d3.id
  end
end
