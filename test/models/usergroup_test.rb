require 'test_helper'

class UsergroupTest < ActiveSupport::TestCase
  test 'Create Usergroup' do
    old_count = Usergroup.count

    ug = Usergroup.new
    assert ug.save
    assert Usergroup.count == old_count + 1
  end

  test 'Add group to usergroup' do
    u = users(:userone)

    ug = Usergroup.create

    g = Group.new
    g.group_id = ug.id
    g.user_id = u.id
    g.save!
  end

  test 'Delete usergroup' do
    ug = Usergroup.create

    assert ug.deleted_at.nil?
    ug.delete
    assert !ug.deleted_at.nil?
  end
end
