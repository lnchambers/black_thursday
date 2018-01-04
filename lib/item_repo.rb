require 'pry'

require_relative 'item'
require_relative 'create_elements'

class ItemRepo
  attr_reader :items,
              :parent

  include CreateElements

  def initialize(data, parent)
    @items = {}
    create_elements(data).each do |row|
      @items[row[:id]] = Item.new(row)
    end
    @parent = parent
  end

  def all
    return @items.values
  end

  def find_by_id(id)
    @items[id]
  end

  def find_by_name(name)
    @items.values.find do |item|
      return item if item.name.downcase.include? name.downcase
    end
  end

  def find_all_with_description(description)
    @items.values.find_all do |item|
      item.name.downcase.include? name.downcase
    end
  end

  def find_all_by_price(price)
    @items.values.reduce([]) do |result, item|
      result << item if item.unit_price.to_i == price
      result
    end
  end

  def find_all_by_price_in_range(low, high)
    @items.reduce([]) do |result, item|
      if item.unit_price.include?(low.to_i..high.to_i)
        result << merchant
      else
        result
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.reduce([]) do |result, item|
      if item.merchant_id == merchant_id
        result << merchant
      else
        result
      end
    end
  end

end
