require 'pry'

require_relative 'item'
require_relative 'create_elements'

class ItemRepo
  attr_reader :items,
              :parent

  include CreateElements

  def initialize(data, parent)
    @items = create_elements(data).reduce({}) do |result, item|
      result[item[:id].to_i] = Item.new(item)
      result
    end
    @parent = parent
  end

  def all
    return @items
  end

  def find_by_id(id)
    @items.map do |item|
      return item if item.id.to_i == id
    end
  end

  def find_by_name(name)
    @items.map do |item|
      return item if item.name == name
    end
  end

  def find_all_with_description(description)
    @items.reduce([]) do |result, item|
      if item.description == description
        result << item
      else
        result
      end
    end
  end

  def find_all_by_price(price)
    @items.reduce([]) do |result, item|
      if item.unit_price.to_i == price
        result << item
      else
        result
      end
    end
  end

  def find_all_by_price_in_range(low, high)
    @items.reduce([]) do |result, item|
      if item.unit_price.include?(low.to_i..high.to_i)#(item.unit_price)
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
