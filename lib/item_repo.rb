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
      @items[row[:id].to_i] = Item.new(row)
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
      item.description.downcase.include? description.downcase
    end
  end

  def find_all_by_price(price)
    @items.values.find_all do |item|
      item.unit_price.include? price
    end
  end

  def find_all_by_price_in_range(range)
    @items.reduce([]) do |result, item|
      if range.include? item.unit_price
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
