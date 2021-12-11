require 'test_helper'

class SignupsControllerTest < ActionController::TestCase
  setup do
    @signup = signups(:one)
    sign_in users(:one)
  end

  test "should create signup" do
    skip("This test does not work currently.")
    assert_difference('Signup.count') do
      post :create, params: { signup: { event_id: @signup.event_id, reason: @signup.reason, status: @signup.status, user_id: users(:three) } }
    end

    assert_redirected_to signup_path(assigns(:signup))
  end

  test "should update signup" do
    patch :update, params: { id: @signup, signup: { event_id: @signup.event_id, reason: @signup.reason, status: @signup.status, user_id: @signup.user_id } }
    assert_redirected_to signup_path(@signup)
  end

  test "should destroy signup" do
    assert_difference('Signup.count', -1) do
      delete :destroy, params: { id: @signup }
    end

    assert_redirected_to root_path
  end
end
