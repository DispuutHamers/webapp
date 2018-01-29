require 'test_helper'

class BrewsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get brews_show_url
    assert_response :success
  end

  test "should get new" do
    get brews_new_url
    assert_response :success
  end

  test "should get create" do
    get brews_create_url
    assert_response :success
  end

  test "should get edit" do
    get brews_edit_url
    assert_response :success
  end

  test "should get update" do
    get brews_update_url
    assert_response :success
  end

  test "should get destroy" do
    get brews_destroy_url
    assert_response :success
  end

end
