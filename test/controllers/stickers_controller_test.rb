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
    get :create#, params: { wat gaat hier in? }
    assert_response :success
  end

  test "should get update" do
    get :update, params: { id: @sticker }
    assert_response :success
  end

  test "should get show" do
    get :show, params: { id: @sticker }
    assert_response :success
  end

end
