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
    @merchants.select do |id, merchant|
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @merchants.reduce([]) do |result, merchant|
      if merchant.name == name
        result << merchant
      else
        result
      end
    end
  end

end
