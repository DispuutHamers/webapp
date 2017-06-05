require 'test_helper'

class GroupsTest < ActiveSupport::TestCase
  test 'Create group' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'hamertester@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    ug = Usergroup.new
    ug.save!

    old_count = Group.count

    g = Group.new
    g.user_id = u.id
    g.group_id = ug.id
    g.save!

    assert g.group_id == ug.id
    assert g.user_id == u.id

    assert Group.count == old_count + 1
  end

  test 'Delete group' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'hamertester@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    ug = Usergroup.new
    ug.save!

    g = Group.new
    g.user_id = u.id
    g.group_id = ug.id
    g.save!

    assert g.deleted_at == nil
    g.delete
    assert g.deleted_at != nil
  end

  test 'Group has to have group_id and user_id' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'hamertester@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    ug = Usergroup.new
    ug.save!

    assert_raise do
      g = Group.new
      g.save!
    end

    assert_raise do
      g = Group.new
      g.user_id = u.id
      g.save!
    end

    assert_raise do
      g = Group.new
      g.group_id = ug.id
      g.save!
    end

    assert_nothing_raised do
      g = Group.new
      g.user_id = u.id
      g.group_id = ug.id
      g.save!
    end
  end

  test 'Add user to group' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'hamertester@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    u2 = User.new
    u2.name = 'Hamer Tester 2'
    u2.email = 'hamertester2@zondersikkel.nl'
    u2.password = 'hamers'
    u2.save!

    ug = Usergroup.new
    ug.save!

    g = Group.new
    g.user_id = u.id
    g.group_id = ug.id
    g.save!

    g2 = Group.new
    g2.user_id = u2.id
    g2.group_id = ug.id
    g2.save!

    assert ug.users[0].id == u.id
    assert ug.users[1].id == u2.id

    assert u.groups[0].group_id == ug.id
    assert u2.groups[0].group_id == ug.id
  end

  test 'Add user to multiple user groups' do
    u = User.new
    u.name = 'Hamer Tester'
    u.email = 'hamertester@zondersikkel.nl'
    u.password = 'hamers'
    u.save!

    ug = Usergroup.new
    ug.save!

    ug2 = Usergroup.new
    ug2.save!

    g = Group.new
    g.user_id = u.id
    g.group_id = ug.id
    g.save!

    g2 = Group.new
    g2.user_id = u.id
    g2.group_id = ug2.id
    g2.save!

    assert u.groups[0].group_id == ug.id
    assert u.groups[1].group_id == ug2.id
  end
end
