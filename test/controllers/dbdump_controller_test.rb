require 'test_helper'

class DbdumpControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
