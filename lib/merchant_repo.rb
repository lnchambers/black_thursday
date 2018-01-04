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
      @merchants[row[:id].to_i] = Merchant.new(row)
    end
    @parent = parent
  end

  def all
    return @merchants
  end

  def find_by_id(id)
    @merchants[id]
  end

  def find_by_name(name)
    @merchants.values.find do |merchant|
      return merchant if merchant.name.downcase.include? name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.values.find do |result, merchant|
      result << merchant[1] if merchant[1].name == name
      result
    end
  end
end
