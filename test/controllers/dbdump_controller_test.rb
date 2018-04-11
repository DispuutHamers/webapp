require 'test_helper'

class DbdumpControllerTest < ActionController::TestCase
  def setup
    sign_in users(:one)
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
