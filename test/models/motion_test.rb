require 'test_helper'

class MotionTest < ActiveSupport::TestCase
  test "Motion belongs to user" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save

    m = Motion.new
    m.user_id = u.id
    assert m.save

    m2 = Motion.new
    m2.user_id = u.id
    assert m2.save

    assert m.user_id == u.id
    assert u.motions[0].id == m.id
    assert u.motions[1].id == m2.id
  end

  test "Delete motion" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save

    m = Motion.new
    m.user_id = u.id
    m.save

    assert m.deleted_at == nil
    m.delete
    assert m.deleted_at != nil
  end

  test "Update motion" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "testhamer@zondersikkel.nl"
    u.password = "hamers"
    u.save

    m = Motion.new
    m.user_id = u.id
    m.save

    # TODO: how to update motion?
    updated = m.updated_at
    assert updated != nil
    # Uncomment line below when found out how to update a motion
    # assert m.updated_at > updated
  end

end
