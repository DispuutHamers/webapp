require 'test_helper'

class GroupsTest < ActiveSupport::TestCase
  test 'Create group' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    ug = Usergroup.create

    old_count = Group.count

    g = Group.create(user_id: u.id, group_id: ug.id)
    assert g.save

    assert g.group_id == ug.id
    assert g.user_id == u.id

    assert Group.count == old_count + 1
  end

  test 'Delete group' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    ug = Usergroup.create

    g = Group.create(user_id: u.id, group_id: ug.id)

    assert g.deleted_at.nil?
    g.delete
    assert !g.deleted_at.nil?
  end

  test 'Group has to have group_id and user_id' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    ug = Usergroup.create

    assert !Group.create.save
    assert !Group.create(user_id: u.id).save
    assert !Group.create(group_id: ug.id).save

    assert Group.create(user_id: u.id, group_id: ug.id).save
  end

  test 'Add user to group' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    u2 = User.create(name: 'Hamer Tester 2',
                     email: 'testhamer2@zondersikkel.nl',
                     password: 'Hamers')

    ug = Usergroup.create

    Group.create(user_id: u.id, group_id: ug.id)
    Group.create(user_id: u2.id, group_id: ug.id)

    assert ug.users[0].id == u.id
    assert ug.users[1].id == u2.id

    assert u.groups[0].group_id == ug.id
    assert u2.groups[0].group_id == ug.id
  end

  test 'Add user to multiple user groups' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    ug = Usergroup.create

    ug2 = Usergroup.create

    Group.create(user_id: u.id, group_id: ug.id)
    Group.create(user_id: u.id, group_id: ug2.id)

    assert u.groups[0].group_id == ug.id
    assert u.groups[1].group_id == ug2.id
  end
end
