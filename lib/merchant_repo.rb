require 'pry'
require_relative 'merchant'
require_relative 'create_elements'

class MerchantRepo
  include CreateElements

  attr_reader :merchants,
              :parent

  def initialize(data, parent)
    @merchants = {}
    create_elements(data).each do |row|
      @merchants[row[:id]] = Merchant.new(row)
    end
    @parent = parent
  end

  def all
    return @merchants
  end

  def find_by_id(id)
    @merchants[id.to_s]
  end

  def find_by_name(name)
    @merchants.each do |merchant|
      return merchant[1] if merchant[1].name == name
    end
  end

  def find_all_by_name(name)
    @merchants.reduce([]) do |result, merchant|
      result << merchant[1] if merchant[1].name == name
      result
    end
  end
end
