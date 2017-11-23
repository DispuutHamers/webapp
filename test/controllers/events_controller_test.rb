require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:eventone)
    sign_in users(:userone)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
