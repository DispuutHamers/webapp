require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup 
    sign_in users(:userone)
  end

  test "should get home" do
    get :home
    assert_response :success
  end

end
