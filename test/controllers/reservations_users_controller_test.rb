require 'test_helper'

class ReservationsUsersControllerTest < ActionController::TestCase
  setup do
    @reservation = reservations(:two)
    @user = users(:adam)
    log_in_as(@user)
  end

  test "should sign in user to reservation" do
    assert_difference('@reservation.users.count') do
      post :create, id: @reservation.id
    end
  end

  test "should sign out user from reservation" do
    assert_no_difference('@reservation.users.count') do
      post :create, id: @reservation.id
      post :destroy, id: @reservation.id
    end
  end


end
