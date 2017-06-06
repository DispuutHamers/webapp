require 'test_helper'

class GroupsTest < ActiveSupport::TestCase
  test 'Create group' do
    u = users(:userone)

    ug = Usergroup.create

    old_count = Group.count

    g = Group.create(user_id: u.id, group_id: ug.id)
    assert g.save

    assert g.group_id == ug.id
    assert g.user_id == u.id

    assert Group.count == old_count + 1
  end

  test 'Delete group' do
    g = groups(:groupone)

    assert g.deleted_at.nil?
    g.delete
    assert !g.deleted_at.nil?
  end

  test 'Group has to have group_id and user_id' do
    u = users(:userone)

    ug = usergroups(:usergroupone)

    assert !Group.create.save
    assert !Group.create(user_id: u.id).save
    assert !Group.create(group_id: ug.id).save
  end

  test 'Add user to group' do
    u = users(:userthree)

    u2 = users(:userfour)

    # new usergroup, users aren't yet added to it
    ug = usergroups(:usergroupthree)

    Group.create(user_id: u.id, group_id: ug.id)
    Group.create(user_id: u2.id, group_id: ug.id)

    assert_equal ug.users[0].id, u.id
    assert_equal ug.users[1].id, u2.id

    assert_equal u.groups[0].group_id, ug.id
    assert_equal u2.groups[0].group_id, ug.id
  end

  test 'Add user to multiple user groups' do
    # userthree since user three isn't yet in the groups created below
    u = users(:userthree)

    ug = usergroups(:usergroupone)
    ug2 = usergroups(:usergrouptwo)

    Group.create(user_id: u.id, group_id: ug.id)
    Group.create(user_id: u.id, group_id: ug2.id)

    assert_equal u.groups[0].group_id, ug.id
    assert_equal u.groups[1].group_id, ug2.id
  end
end
