require 'test_helper'

class NewsControllerTest < ActionController::TestCase
  setup do
    @news = news(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create news" do
    assert_difference('News.count') do
      post :create, params: { news: { body: @news.body, cat: @news.cat, date: @news.date, title: @news.title } }
    end

    assert_response :redirect
  end

  test "should show news" do
    get :show, params: { id: @news }
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, params: { id: @news }
    assert_response :success
  end

  test "should update news" do
    patch :update, params: { id: @news, news: { body: @news.body, cat: @news.cat, date: @news.date, title: @news.title } }
    assert_redirected_to news_path(assigns(:news))
  end

  test "should destroy news" do
    assert_difference('News.count', -1) do
      delete :destroy, params: { id: @news }
    end

    assert_redirected_to root_path
  end
end
