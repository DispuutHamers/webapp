require 'test_helper'

class NicknameTest < ActiveSupport::TestCase
  test 'Create nickname' do
    u = users(:userone)

    old_count = Nickname.count

    nickname = 'Spijker'
    Nickname.create(nickname: nickname, user_id: u.id)

    assert_equal Nickname.count, old_count + 1
  end
  test 'Give user a nickname' do
    u = users(:userone)

    nickname = 'Spijker'
    Nickname.create(nickname: nickname, user_id: u.id)

    nickname2 = 'Spijkertje'
    Nickname.create(nickname: nickname2, user_id: u.id)

    assert_equal u.nickname, nickname2 + ' ' + nickname + ' '
    assert_equal u.nicknames[0].nickname, nickname
    assert_equal u.nicknames[1].nickname, nickname2
  end

  test 'Delete a nickname' do
    u = users(:userone)

    nickname = 'Spijker'
    n = Nickname.create(nickname: nickname, user_id: u.id)

    assert n.deleted_at.nil?
    n.delete
    assert !n.deleted_at.nil?
  end

  test 'Update a nickname' do
    u = users(:userone)

    nickname = 'Spijker'
    n = Nickname.create(nickname: nickname, user_id: u.id)

    updated = n.updated_at
    # sleep 2 seconds because updated_at has to be a change in datetime
    sleep(2)
    n.update(nickname: 'Spijkertje')
    assert_equal n.nickname, 'Spijkertje'
    assert n.updated_at > updated
  end
end
