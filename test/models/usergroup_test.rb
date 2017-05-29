require 'test_helper'

class UsergroupTest < ActiveSupport::TestCase
  test "Create Usergroup" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    ug = Usergroup.new
    ug.save!
  end

  test "Add group" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    ug = Usergroup.new
    ug.save!

    g = Group.new
    g.group_id = ug.id
    g.user_id = u.id
    g.save!
  end

  test "Delete usergroup" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    ug = Usergroup.new
    ug.save!

    assert ug.deleted_at == nil
    ug.delete
    assert ug.deleted_at != nil
  end
end
