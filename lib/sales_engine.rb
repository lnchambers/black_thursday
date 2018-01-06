require 'pry'
require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(data)
    @items = ItemRepo.new(data[:items], self)
    @merchants = MerchantRepo.new(data[:merchants], self)
    @invoices = InvoiceRepo.new(data[:invoices], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def find_merchants(id)
    merchants.find_by_id(id)
  end

  def find_item_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

end
