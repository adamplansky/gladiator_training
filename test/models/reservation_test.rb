require 'test_helper'

class ReservationTest < ActiveSupport::TestCase


  def setup
    @place = places(:one)
    @user = users(:adam)
    @category = categories(:one)
    @reservation = Reservation.new(time_from: "2015-09-10 21:29:56",time_to: "2015-09-10 21:29:56", money: 11, capacity: 30, place: @place, user:@user, category: @category)
  end

  test "reservation should be valid" do
    assert @reservation.valid?
  end

  test "reservation should not be valid" do
    @reservation.user = nil
    assert_not @reservation.valid?
  end

  test "reservation time_from should be present" do
    @reservation.time_from = nil
    assert_not @reservation.valid?
  end

  test "reservation time_to should be present" do
    @reservation.time_to = nil
    assert_not @reservation.valid?
  end

  test "reservation time_to should be valid datetime" do
    @reservation.time_to = DateTime.now.to_s(:db)
    assert @reservation.valid?
  end

  test "reservation time_from should be valid datetime" do
    @reservation.time_from = DateTime.now.to_s(:db)
    assert @reservation.valid?
  end

  test "reservation time_from should not be valid" do
    @reservation.time_from = 'not valid datetime'
    assert_not @reservation.valid?
  end

  test "reservation time_to should not be valid" do
    @reservation.time_to = 'not valid datetime'
    assert_not @reservation.valid?
  end




end
