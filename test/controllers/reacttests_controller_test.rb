require 'test_helper'

class ReacttestsControllerTest < ActionController::TestCase
  setup do
    @reacttest = reacttests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reacttests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reacttest" do
    assert_difference('Reacttest.count') do
      post :create, reacttest: {  }
    end

    assert_redirected_to reacttest_path(assigns(:reacttest))
  end

  test "should show reacttest" do
    get :show, id: @reacttest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reacttest
    assert_response :success
  end

  test "should update reacttest" do
    patch :update, id: @reacttest, reacttest: {  }
    assert_redirected_to reacttest_path(assigns(:reacttest))
  end

  test "should destroy reacttest" do
    assert_difference('Reacttest.count', -1) do
      delete :destroy, id: @reacttest
    end

    assert_redirected_to reacttests_path
  end
end
