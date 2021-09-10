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

  test 'api key belongs to user' do
    @key.save

    key2 = ApiKey.create(user: users(:two))

    @user.reload

    assert @key.user = @user
    assert key2.user = @user

    assert_includes @user.api_keys, @key
    assert_includes @user.api_keys, key2
  end

  test 'ApiKey only belongs to 1 user' do
    u = users(:one)
    u2 = users(:two)

    apikey = ApiKey.new
    apikey.user_id = u.id
    apikey.save!

    apikey2 = ApiKey.new
    apikey2.user_id = u2.id
    apikey2.save!

    assert apikey.user_id == u.id && apikey.user_id != u2.id
    assert apikey2.user_id == u2.id && apikey2.user_id != u.id

    assert u.api_keys != u2.api_keys
  end
end
