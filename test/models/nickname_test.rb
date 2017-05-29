require 'test_helper'

class NicknameTest < ActiveSupport::TestCase
  test "Give user a nickname" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    nickname = "Spijker"
    n = Nickname.new
    n.nickname = nickname
    n.user_id = u.id
    n.save!

    nickname2 = "Spijkertje"
    n2 = Nickname.new
    n2.nickname = nickname2
    n2.user_id = u.id
    n2.save!

    assert u.nickname == nickname2 + " " + nickname + " "
    assert u.nicknames[0].nickname == nickname
    assert u.nicknames[1].nickname == nickname2
  end

  test "Delete a nickname" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    nickname = "Spijker"
    n = Nickname.new
    n.nickname = nickname
    n.user_id = u.id
    n.save!

    assert n.deleted_at == nil
    n.delete
    assert n.deleted_at != nil
  end

  test "Update a nickname" do
    u = User.new
    u.name = "Hamer Tester"
    u.email = "hamertester@zondersikkel.nl"
    u.password = "hamers"
    u.save!

    nickname = "Spijker"
    n = Nickname.new
    n.nickname = nickname
    n.user_id = u.id
    n.save!

    updated = n.updated_at
    # TODO: how to update a nickname?
    # sleep(1)
    # assert n.updated_at > updated
  end
end
