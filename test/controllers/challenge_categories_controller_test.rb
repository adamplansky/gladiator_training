require 'test_helper'

class ChallengeCategoriesControllerTest < ActionController::TestCase
  setup do
    @challenge_category = challenge_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:challenge_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create challenge_category" do
    assert_difference('ChallengeCategory.count') do
      post :create, challenge_category: { name: @challenge_category.name }
    end

    assert_redirected_to challenge_category_path(assigns(:challenge_category))
  end

  test "should show challenge_category" do
    get :show, id: @challenge_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @challenge_category
    assert_response :success
  end

  test "should update challenge_category" do
    patch :update, id: @challenge_category, challenge_category: { name: @challenge_category.name }
    assert_redirected_to challenge_category_path(assigns(:challenge_category))
  end

  test "should destroy challenge_category" do
    assert_difference('ChallengeCategory.count', -1) do
      delete :destroy, id: @challenge_category
    end

    assert_redirected_to challenge_categories_path
  end
end
