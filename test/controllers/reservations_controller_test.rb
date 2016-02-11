require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  setup do
    @reservation = reservations(:one)
    @place = places(:one)
    @user = users(:adam)
    @category = categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reservations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post :create, reservation: { capacity: 30, time_from: (DateTime.now).to_s(:db), time_to: (DateTime.now).to_s(:db), place_id: @place.id, category_id: @category.id}
    end
    assert_redirected_to reservation_path
  end


end
