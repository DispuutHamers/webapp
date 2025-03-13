require 'test_helper'

class GroupsTest < ActiveSupport::TestCase
  test 'Create group' do
    u = users(:two)

    ug = Usergroup.create(name: 'test')

    old_count = Group.count

    g = Group.create(user_id: u.id, group_id: ug.id)
    assert g.save

    assert g.group_id == ug.id
    assert g.user_id == u.id

    assert Group.count == old_count + 1
  end

  test 'Delete group' do
    g = groups(:one)

    assert g.deleted_at.nil?
    g.delete
    assert !g.deleted_at.nil?
  end

  test 'Group has to have group_id and user_id' do
    u = users(:one)

    ug = usergroups(:one)

    assert !Group.create.save
    assert !Group.create(user_id: u.id).save
    assert !Group.create(group_id: ug.id).save
  end

  test 'Add user to group' do
    u = users(:three)

    u2 = users(:four)

    # new usergroup, users aren't yet added to it
    ug = usergroups(:three)

    Group.create(user_id: u.id, group_id: ug.id)
    Group.create(user_id: u2.id, group_id: ug.id)

    assert_includes ug.users, u
    assert_includes ug.users, u2

    assert_equal u.groups[0].group_id, ug.id
    assert_equal u2.groups[0].group_id, ug.id
  end

  test 'Add user to multiple user groups' do
    # userthree since user three isn't yet in the groups created below
    u = users(:three)

    ug = usergroups(:one)
    ug2 = usergroups(:two)

    Group.create(user_id: u.id, group_id: ug.id)
    Group.create(user_id: u.id, group_id: ug2.id)

    assert_equal u.groups[0].group_id, ug.id
    assert_equal u.groups[1].group_id, ug2.id
  end
end
