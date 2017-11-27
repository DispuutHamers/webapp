require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, params: { user: { email: "Random@email.com", name: "Naam" } }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, params: { id: @user.id }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @user }
    assert_response :success
  end

  test "should update user" do
    patch :update, params: { id: @user, user: { email: @user.email, name: @user.name } }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', 0) do
      delete :destroy, params: { id: @user }
    end

    assert_redirected_to root_path
  end
end
