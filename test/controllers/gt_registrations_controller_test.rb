require 'test_helper'

class GtRegistrationsControllerTest < ActionController::TestCase
  setup do
    @gt_registration = gt_registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gt_registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gt_registration" do
    assert_difference('GtRegistration.count') do
      post :create, gt_registration: { birth: @gt_registration.birth, city: @gt_registration.city, code: @gt_registration.code, firstname: @gt_registration.firstname, gt_race_id: @gt_registration.gt_race_id, notes: @gt_registration.notes, phone_number: @gt_registration.phone_number, price: @gt_registration.price, psc: @gt_registration.psc, sex: @gt_registration.sex, street: @gt_registration.street, surname: @gt_registration.surname }
    end

    assert_redirected_to gt_registration_path(assigns(:gt_registration))
  end

  test "should show gt_registration" do
    get :show, id: @gt_registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gt_registration
    assert_response :success
  end

  test "should update gt_registration" do
    patch :update, id: @gt_registration, gt_registration: { birth: @gt_registration.birth, city: @gt_registration.city, code: @gt_registration.code, firstname: @gt_registration.firstname, gt_race_id: @gt_registration.gt_race_id, notes: @gt_registration.notes, phone_number: @gt_registration.phone_number, price: @gt_registration.price, psc: @gt_registration.psc, sex: @gt_registration.sex, street: @gt_registration.street, surname: @gt_registration.surname }
    assert_redirected_to gt_registration_path(assigns(:gt_registration))
  end

  test "should destroy gt_registration" do
    assert_difference('GtRegistration.count', -1) do
      delete :destroy, id: @gt_registration
    end

    assert_redirected_to gt_registrations_path
  end
end
