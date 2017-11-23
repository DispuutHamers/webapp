require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, params: { note: { content: @note.content, title: @note.title } }
    end

    assert_redirected_to note_path(assigns(:note))
  end

  test "should show note" do
    get :show, params: { id: @note }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @note }
    assert_response :success
  end

  test "should update note" do
    patch :update, params: { id: @note, note: { content: @note.content, title: @note.title } }
    assert_redirected_to note_path(assigns(:note))
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete :destroy, params: { id: @note }
    end

    assert_redirected_to notes_path
  end
end
