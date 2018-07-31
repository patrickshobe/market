require 'pry'

class Market
  attr_reader :name,
              :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory[item] != 0
    end
  end

  def sorted_item_list
    @vendors.map(&:inventory).map do |hash|
      hash.keys
    end.flatten.uniq.sort
  end

  def total_inventory
    total = Hash[sorted_item_list.map {|item| [item, 0]}]
    nested_hash = @vendors.map(&:inventory)
    nested_hash.each do |hash|
      hash.each do |key, value|
        total[key] += value
      end
    end
    total
  end

  def sell(item, quantity)
    return false if total_inventory[item] < quantity
    @vendors.each do |vendor|
      if vendor.inventory[item] == 0
        next
      elsif vendor.inventory[item] - quantity > 0
        vendor.inventory[item] -= quantity
      else
        new_quantity -= vendor.inventory[item]
        vendor.inventory[item] - quantity
        sell(item, new_quantity)
      end
    end
    true
  end
end
