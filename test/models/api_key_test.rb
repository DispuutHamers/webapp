require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  test 'Create ApiKey' do
    u = users(:userone)

    old_count = ApiKey.count

    apikey = ApiKey.new
    apikey.user_id = u.id
    apikey.save!

    assert ApiKey.count == old_count + 1
  end

  test 'ApiKey belongs to user' do
    # user two doesn't have an api key yet
    u = users(:usertwo)

    apikey = ApiKey.new
    apikey.user_id = u.id
    apikey.save!

    apikey2 = ApiKey.new
    apikey2.user_id = u.id
    apikey2.save!

    assert apikey.user_id == u.id
    assert apikey2.user_id == u.id
    assert u.api_keys[0].id == apikey.id
    assert u.api_keys[1].id == apikey2.id
  end

  test 'ApiKey only belongs to 1 user' do
    u = users(:userone)
    u2 = users(:usertwo)

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
