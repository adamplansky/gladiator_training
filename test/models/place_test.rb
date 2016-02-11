require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  def setup
    @place = Place.new(name:'telocvicna xyz', map_url:'http://bit.ly/20NshLX')
  end

  test "should be valid" do
    assert @place.valid?
  end

  test "place name should be present" do
    @place.name = ''
    assert_not @place.valid?
  end

  test "place map_url should be present" do
    @place.map_url = "   "
    assert_not @place.valid?
  end



end
