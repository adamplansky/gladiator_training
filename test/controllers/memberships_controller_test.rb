require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  test "should get member" do
    get :member
    assert_response :success
  end

  test "should get notmember" do
    get :notmember
    assert_response :success
  end

  test "should get others" do
    get :others
    assert_response :success
  end

end
