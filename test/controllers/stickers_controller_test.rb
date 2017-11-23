require 'test_helper'

class StickersControllerTest < ActionController::TestCase
  setup do
    sign_in users(:userone)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
