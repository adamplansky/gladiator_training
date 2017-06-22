require 'test_helper'

class GtPricesControllerTest < ActionController::TestCase
  setup do
    @gt_price = gt_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gt_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gt_price" do
    assert_difference('GtPrice.count') do
      post :create, gt_price: { GTRace_id: @gt_price.GTRace_id, price: @gt_price.price, until: @gt_price.until }
    end

    assert_redirected_to gt_price_path(assigns(:gt_price))
  end

  test "should show gt_price" do
    get :show, id: @gt_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gt_price
    assert_response :success
  end

  test "should update gt_price" do
    patch :update, id: @gt_price, gt_price: { GTRace_id: @gt_price.GTRace_id, price: @gt_price.price, until: @gt_price.until }
    assert_redirected_to gt_price_path(assigns(:gt_price))
  end

  test "should destroy gt_price" do
    assert_difference('GtPrice.count', -1) do
      delete :destroy, id: @gt_price
    end

    assert_redirected_to gt_prices_path
  end
end
