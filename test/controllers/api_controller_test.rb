require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get GET" do
    get :GET
    assert_response :success
  end

  test "should get POST" do
    get :POST
    assert_response :success
  end

  test "should get PUT" do
    get :PUT
    assert_response :success
  end

  test "should get DESTROY" do
    get :DESTROY
    assert_response :success
  end

end
