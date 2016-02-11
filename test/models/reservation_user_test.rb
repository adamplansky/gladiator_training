require 'test_helper'

class ReservationUserTest < ActiveSupport::TestCase


  def setup
    @user = users(:adam)
    @reservation = reservations(:one)
  end

  test "user reservate training" do
    @reservation.users << @user
    assert @reservation.users.include?(@user)
  end

end
