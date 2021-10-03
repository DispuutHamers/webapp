require 'test_helper'

class PublicPagesControllerTest < ActionController::TestCase
  setup do
    @public_page = public_pages(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:public_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create public_page" do
    assert_difference('PublicPage.count') do
      post :create, params: { public_page: { content: @public_page.content, public: @public_page.public, title: @public_page.title } }
    end

    assert_redirected_to public_page_path(id: PublicPage.last.id)
  end

  test "should show public_page" do
    get :show, params: { id: @public_page.title }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @public_page }
    assert_response :success
  end

  test "should update public_page" do
    patch :update, params: { id: @public_page, public_page: { content: @public_page.content, public: @public_page.public, title: @public_page.title } }
    assert_redirected_to public_page_path(assigns(:public_page))
  end

  test "should destroy public_page" do
    assert_difference('PublicPage.count', -1) do
      delete :destroy, params: { id: @public_page }
    end

    assert_redirected_to public_pages_path
  end
end
