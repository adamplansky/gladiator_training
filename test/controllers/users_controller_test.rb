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
  #
  # test "should show user" do
  #   get :show, id: @user
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @user
  #   assert_response :success
  # end
  #
  # test "should update user" do
  #   patch :update, id: @user, user: { : @user., email: @user.email, first_name: @user.first_name, password: @user.password, surname: @user.surname }
  #   assert_redirected_to user_path(assigns(:user))
  # end
  #
  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete :destroy, id: @user
  #   end
  #
  #   assert_redirected_to users_path
  # end
end
