require 'test_helper'

class UsersAdminControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', 0) do
      delete :destroy, params: { id: @user }
    end

    assert_redirected_to users_path
  end
end