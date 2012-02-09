require 'test_helper'

class KazokusControllerTest < ActionController::TestCase
  setup do
    @kazoku = kazokus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kazokus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kazoku" do
    assert_difference('Kazoku.count') do
      post :create, :kazoku => @kazoku.attributes
    end

    assert_redirected_to kazoku_path(assigns(:kazoku))
  end

  test "should show kazoku" do
    get :show, :id => @kazoku
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kazoku
    assert_response :success
  end

  test "should update kazoku" do
    put :update, :id => @kazoku, :kazoku => @kazoku.attributes
    assert_redirected_to kazoku_path(assigns(:kazoku))
  end

  test "should destroy kazoku" do
    assert_difference('Kazoku.count', -1) do
      delete :destroy, :id => @kazoku
    end

    assert_redirected_to kazokus_path
  end
end
