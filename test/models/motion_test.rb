require 'test_helper'

class MotionTest < ActiveSupport::TestCase
  test 'Create motion' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    old_count = Motion.count

    assert Motion.create(user_id: u.id).save

    assert Motion.count == old_count + 1
  end
  test 'Motion belongs to user' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    m = Motion.create(user_id: u.id)

    m2 = Motion.create(user_id: u.id)

    assert m.user_id == u.id
    assert u.motions[0].id == m.id
    assert u.motions[1].id == m2.id
  end

  test 'Delete motion' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    m = Motion.create(user_id: u.id)

    assert m.deleted_at.nil?
    m.delete
    assert !m.deleted_at.nil?
  end

  test 'Update motion' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    m = Motion.create(user_id: u.id)

    # TODO: how to update motion?
    updated = m.updated_at
    assert !updated.nil?
    # Uncomment line below when found out how to update a motion
    # assert m.updated_at > updated
  end
end
