require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @key = ApiKey.new(user: @user)
  end

  test 'valid api key' do
    assert @key.valid?
  end

  test 'creates random key' do
    @key.save

    assert_not_nil @key.key
  end

  test 'api key belongs to (single) user' do
    @key.save

    key2 = ApiKey.create(user: users(:one))
    key3 = ApiKey.create(user: users(:three))

    assert_equal @key.user, @user
    assert_equal key2.user, @user
    assert_not_equal key3.user, @user

    assert_includes @user.api_keys, @key
    assert_includes @user.api_keys, key2
    assert_not_includes @user.api_keys, key3
  end
end
