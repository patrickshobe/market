require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_1.stock("Peaches", 35) 
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom") 
    @vendor_2.stock("Banana Nice Cream", 50)   
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25) 
    @vendor_3 = Vendor.new("Palisade Peach Shack") 
    @vendor_3.stock("Peaches", 65)    
   
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_it_adds_vendors
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)   

    expected =  [@vendor_1, @vendor_2, @vendor_3]
    actual = @market.vendors

    assert_equal expected, actual
  end

  def test_it_returns_sorted_item_list
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)   

    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    actual = @market.sorted_item_list

    assert_equal expected, actual
  end

  def test_it_returns_total_inventory
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)  
    
    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    actual = @market.total_inventory

    assert_equal expected, actual
  end

  def test_it_returns_vendor_names
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)  

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    actual = @market.vendor_names

    assert_equal expected, actual
  end

  def test_it_returns_vendors_that_sell_items
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)

    expected = [@vendor_1, @vendor_3] 
    actual = @market.vendors_that_sell("Peaches")

     assert_equal expected, actual
  end

  def test_it_fails_to_sell
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)

    expected = false
    actual = @market.sell("Peaches", 200)
    assert_equal expected, actual
  end

  def test_it_sells
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)
    
    expected = true
    actual = @market.sell("Banana Nice Cream", 5)

    assert_equal expected, actual
  end

  def test_selling_reduces_stock_from_first
    @market.add_vendor(@vendor_1)    
    @market.add_vendor(@vendor_2)    
    @market.add_vendor(@vendor_3)
    @market.sell("Peaches", 5)
 

    expected = 30
    actual = @vendor_1.check_stock("Peaches")

    assert_equal expected, actual
  end
end
