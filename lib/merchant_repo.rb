require 'pry'
require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'create_elements'

class MerchantRepo
  include CreateElements

  attr_reader :merchants,
              :parent

  def initialize(data, parent)
    @merchants = {}
    create_elements(data).each do |row|
      @merchants[row[:id]] = Merchant.new(row, parent)
    end
    @parent = parent
  end

  def all
    return @merchants.values
  end

  def find_by_id(id)
    @merchants[id.to_s]
  end

  def find_item(id)
    @parent.find_item_by_merchant_id
    require "pry"; binding.pry
  end

  def find_by_name(name)
    @merchants.each do |merchant|
      return merchant[1] if merchant[1].name == name
    end
  end

  def find_all_by_name(name)
    found_merchants = []
    @merchants.each do |merchant|
      found_merchants << merchant[1] if merchant[1].name == name
    end
    found_merchants
  end
end
