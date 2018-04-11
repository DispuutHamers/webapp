require 'test_helper'

class MotionTest < ActiveSupport::TestCase
  test 'Create motion' do
    u = users(:one)

    old_count = Motion.count

    assert Motion.create(user_id: u.id).save

    assert_equal Motion.count, old_count + 1
  end
  test 'Motion belongs to user' do
    u = users(:one)

    m = Motion.create(user_id: u.id)

    m2 = Motion.create(user_id: u.id)

    assert m.user_id == u.id
    assert_includes u.motions, m
    assert_includes u.motions, m2
  end

  test 'Delete motion' do
    u = users(:one)

    m = Motion.create(user_id: u.id)

    assert m.deleted_at.nil?
    m.delete
    assert !m.deleted_at.nil?
  end
end
