require 'test_helper'

class BeersControllerTest < ActionController::TestCase
  setup do
    @beer = beers(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
