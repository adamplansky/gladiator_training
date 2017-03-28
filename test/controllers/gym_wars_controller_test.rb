require 'test_helper'

class GymWarsControllerTest < ActionController::TestCase
  setup do
    @gym_war = gym_wars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gym_wars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gym_war" do
    assert_difference('GymWar.count') do
      post :create, gym_war: { description: @gym_war.description }
    end

    assert_redirected_to gym_war_path(assigns(:gym_war))
  end

  test "should show gym_war" do
    get :show, id: @gym_war
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gym_war
    assert_response :success
  end

  test "should update gym_war" do
    patch :update, id: @gym_war, gym_war: { description: @gym_war.description }
    assert_redirected_to gym_war_path(assigns(:gym_war))
  end

  test "should destroy gym_war" do
    assert_difference('GymWar.count', -1) do
      delete :destroy, id: @gym_war
    end

    assert_redirected_to gym_wars_path
  end
end
