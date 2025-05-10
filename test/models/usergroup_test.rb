require 'test_helper'

class UsergroupTest < ActiveSupport::TestCase
  test 'Create Usergroup' do
    old_count = Usergroup.count

    ug = Usergroup.new(name: 'test')
    assert ug.save
    assert Usergroup.count == old_count + 1
  end

  test 'Add group to usergroup' do
    u = users(:three)

    ug = Usergroup.create(name: 'test')

    Group.create!(group_id: ug.id, user_id: u.id)
    assert Group.where(group_id: ug.id, user_id: u.id).count == 1
  end

  test 'Delete usergroup' do
    ug = Usergroup.create(name: 'test')

    assert ug.deleted_at.nil?
    ug.delete
    assert !ug.deleted_at.nil?
  end
end
