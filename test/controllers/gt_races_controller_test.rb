require 'test_helper'

class GtRacesControllerTest < ActionController::TestCase
  setup do
    @gt_race = gt_races(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gt_races)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gt_race" do
    assert_difference('GtRace.count') do
      post :create, gt_race: { name: @gt_race.name, place: @gt_race.place, published: @gt_race.published, text: @gt_race.text, url: @gt_race.url }
    end

    assert_redirected_to gt_race_path(assigns(:gt_race))
  end

  test "should show gt_race" do
    get :show, id: @gt_race
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gt_race
    assert_response :success
  end

  test "should update gt_race" do
    patch :update, id: @gt_race, gt_race: { name: @gt_race.name, place: @gt_race.place, published: @gt_race.published, text: @gt_race.text, url: @gt_race.url }
    assert_redirected_to gt_race_path(assigns(:gt_race))
  end

  test "should destroy gt_race" do
    assert_difference('GtRace.count', -1) do
      delete :destroy, id: @gt_race
    end

    assert_redirected_to gt_races_path
  end
end
