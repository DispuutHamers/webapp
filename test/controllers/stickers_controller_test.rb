require 'test_helper'

class StickersControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @sticker = stickers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    skip("This test does not work currently.")
    get :create#, params: { wat gaat hier in? }
    assert_response :success
  end

  test "should get update" do
    skip("This test does not work currently.")
    get :update, params: { id: @sticker }
    assert_response :success
  end

  test "should get show" do
    skip("This test does not work currently.")
    get :show, params: { id: @sticker }
    assert_response :success
  end
end
