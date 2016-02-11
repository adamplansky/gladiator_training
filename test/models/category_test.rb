require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'crossfit')
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "place name should be present" do
    @category.name = ''
    assert_not @category.valid?
  end
end
