require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:adam)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: 'testinguser@gmail.com', first_name: "testing", surname: 'user', password: 'heslo12345',password_confirmation: 'heslo12345'}
    end
    assert_redirected_to signin_path
  end
end
