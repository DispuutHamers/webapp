require 'test_helper'

class RecipeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipe_index_url
    assert_response :success
  end

  test "should get show" do
    get recipe_show_url
    assert_response :success
  end

  test "should get edit" do
    get recipe_edit_url
    assert_response :success
  end

  test "should get update" do
    get recipe_update_url
    assert_response :success
  end

  test "should get new" do
    get recipe_new_url
    assert_response :success
  end

  test "should get create" do
    get recipe_create_url
    assert_response :success
  end

  test "should get delete" do
    get recipe_delete_url
    assert_response :success
  end

end
