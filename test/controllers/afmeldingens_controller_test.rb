require 'test_helper'

class AfmeldingensControllerTest < ActionController::TestCase
  setup do
    @afmeldingen = afmeldingens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:afmeldingens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create afmeldingen" do
    assert_difference('Afmeldingen.count') do
      post :create, afmeldingen: { reden: @afmeldingen.reden, user_id: @afmeldingen.user_id }
    end

    assert_redirected_to afmeldingen_path(assigns(:afmeldingen))
  end

  test "should show afmeldingen" do
    get :show, id: @afmeldingen
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @afmeldingen
    assert_response :success
  end

  test "should update afmeldingen" do
    patch :update, id: @afmeldingen, afmeldingen: { reden: @afmeldingen.reden, user_id: @afmeldingen.user_id }
    assert_redirected_to afmeldingen_path(assigns(:afmeldingen))
  end

  test "should destroy afmeldingen" do
    assert_difference('Afmeldingen.count', -1) do
      delete :destroy, id: @afmeldingen
    end

    assert_redirected_to afmeldingens_path
  end
end
