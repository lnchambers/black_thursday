require 'pry'
require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'create_elements'

class MerchantRepo
  include CreateElements

  attr_reader :merchants

  def initialize(data, parent)
    @merchants = {}
    create_elements(data).each do |row|
      @merchants[row[:id].to_i] = Merchant.new(row, self)
    end
    @parent = parent
  end

  def all
    return @merchants.values
  end

  def find_by_id(id)
    @merchants[id]
  end

  def find_item(id)
    @parent.find_item_by_merchant_id(id)
  end

  def find_by_name(name)
    @merchants.values.find do |merchant|
      return merchant if merchant.name.downcase.include? name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.values.find_all do |merchant|
      merchant.name.downcase.include? name.downcase
    end
  end

  def find_item_by_merchant_id(id)
    @parent.items.find_all_by_merchant_id(id)
  end

  def find_invoice(id)
    @parent.find_invoices(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
