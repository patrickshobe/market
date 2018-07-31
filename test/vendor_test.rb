require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test

  def setup
    @vendor =  Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_a_name
    expected =  "Rocky Mountain Fresh"
    actual = @vendor.name
    assert_equal expected, actual
  end

  def test_it_holds_no_inventory
    expected = {}
    actual = @vendor.inventory
  end

  def test_it_starts_with_no_stock
    expected = 0
    actual = @vendor.check_stock("Peaches")
  end

  def test_it_stocks
    expected = 30
    actual =  @vendor.stock("Peaches", 30)
  end

  def test_it_holds_stock
    expected = 30
    @vendor.stock("Peaches", 30)
    actual = @vendor.check_stock("Peaches")
  end

end
