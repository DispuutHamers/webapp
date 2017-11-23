require 'test_helper'

class BeersControllerTest < ActionController::TestCase
  setup do
    @beer = beers(:beerone)
    sign_in users(:userone)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:beers)
  end

end
