require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @key = ApiKey.new(user: @user, name: "Key 1")
  end

  test 'valid api key' do
    assert @key.valid?
  end

  test 'invalid without name' do
    @key.name = nil
    refute @key.valid?
  end

  test 'invalid with blank name' do
    @key.name = ''
    refute @key.valid?
  end

  test 'invalid if user does not exist' do
    @key.user_id = -1
    refute @key.valid?
  end

  test 'creates random key' do
    @key.save
    assert_not_nil @key.key
  end

  test 'api key belongs to (single) user' do
    @key.save

    key2 = ApiKey.create(user: users(:one), name: "Key 2")
    key3 = ApiKey.create(user: users(:three), name: "Key 3")

    assert_equal @key.user, @user
    assert_equal key2.user, @user
    assert_not_equal key3.user, @user

    assert_includes @user.api_keys, @key
    assert_includes @user.api_keys, key2
    assert_not_includes @user.api_keys, key3
  end

  test 'api key does not have versions (papertrail)' do
    assert_raises NoMethodError do
      @key.versions
    end
  end
end
