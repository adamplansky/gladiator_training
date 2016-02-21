require 'test_helper'

class TrainingCategoriesControllerTest < ActionController::TestCase
  setup do
    @training_category = training_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:training_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create training_category" do
    assert_difference('TrainingCategory.count') do
      post :create, training_category: { description: @training_category.description, koef: @training_category.koef, minimum: @training_category.minimum, name: @training_category.name, units: @training_category.units }
    end

    assert_redirected_to training_category_path(assigns(:training_category))
  end

  test "should show training_category" do
    get :show, id: @training_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @training_category
    assert_response :success
  end

  test "should update training_category" do
    patch :update, id: @training_category, training_category: { description: @training_category.description, koef: @training_category.koef, minimum: @training_category.minimum, name: @training_category.name, units: @training_category.units }
    assert_redirected_to training_category_path(assigns(:training_category))
  end

  test "should destroy training_category" do
    assert_difference('TrainingCategory.count', -1) do
      delete :destroy, id: @training_category
    end

    assert_redirected_to training_categories_path
  end
end
