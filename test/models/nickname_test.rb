require 'test_helper'

class NicknameTest < ActiveSupport::TestCase
  test 'Create nickname' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    old_count = Nickname.count

    nickname = 'Spijker'
    Nickname.create(nickname: nickname, user_id: u.id)

    assert Nickname.count == old_count + 1
  end
  test 'Give user a nickname' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    nickname = 'Spijker'
    Nickname.create(nickname: nickname, user_id: u.id)

    nickname2 = 'Spijkertje'
    Nickname.create(nickname: nickname2, user_id: u.id)

    assert u.nickname == nickname2 + ' ' + nickname + ' '
    assert u.nicknames[0].nickname == nickname
    assert u.nicknames[1].nickname == nickname2
  end

  test 'Delete a nickname' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    nickname = 'Spijker'
    n = Nickname.create(nickname: nickname, user_id: u.id)

    assert n.deleted_at.nil?
    n.delete
    assert !n.deleted_at.nil?
  end

  test 'Update a nickname' do
    u = User.create(name: 'Hamer Tester',
                    email: 'testhamer@zondersikkel.nl',
                    password: 'Hamers')

    nickname = 'Spijker'
    Nickname.create(nickname: nickname, user_id: u.id)

    # updated = n.updated_at
    # TODO: how to update a nickname?
    # sleep(1)
    # assert n.updated_at > updated
  end
end
