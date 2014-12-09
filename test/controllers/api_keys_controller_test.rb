require 'test_helper'

class ApiKeysControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

end
