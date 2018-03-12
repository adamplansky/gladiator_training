require 'test_helper'

class GtCategoriesControllerTest < ActionController::TestCase
  setup do
    @gt_category = gt_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gt_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gt_category" do
    assert_difference('GtCategory.count') do
      post :create, gt_category: { name: @gt_category.name, single: @gt_category.single }
    end

    assert_redirected_to gt_category_path(assigns(:gt_category))
  end

  test "should show gt_category" do
    get :show, id: @gt_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gt_category
    assert_response :success
  end

  test "should update gt_category" do
    patch :update, id: @gt_category, gt_category: { name: @gt_category.name, single: @gt_category.single }
    assert_redirected_to gt_category_path(assigns(:gt_category))
  end

  test "should destroy gt_category" do
    assert_difference('GtCategory.count', -1) do
      delete :destroy, id: @gt_category
    end

    assert_redirected_to gt_categories_path
  end
end
