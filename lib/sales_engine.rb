require 'pry'
require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'customer_repo'
require_relative 'transaction_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions,
              :merchant_data,
              :transaction_data,
              :invoice_item_data

  def initialize(data)
    @invoices      = InvoiceRepo.new(data[:invoices], self)
    @items         = ItemRepo.new(data[:items], self)
    @invoice_items = InvoiceItemRepo.new(data[:invoice_items], self)
    @customers     = CustomerRepo.new(data[:customers], self)
    @transactions  = TransactionRepo.new(data[:transactions], self)
    @merchants     = MerchantRepo.new(data[:merchants], self)
    get_data
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def get_data
    @transaction_data   = transactions.successful_transactions
    # @invoice_item_data  = invoice_items.total(@transaction_data.keys)
    # binding.pry
    @merchant_data      = merchants.get_revenue
  end

  def find_merchants(id)
    merchants.find_by_id(id)
  end

  def find_invoices(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_item_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_invoice_items(id)
    invoice_items.find_by_id(id)
  end

  def find_all_invoice_items(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def find_items_for_invoice(id)
    find_all_invoice_items(id).map do |invoice|
      items.find_by_id(invoice.item_id)
    end
  end

  def find_transactions_for_invoice(id)
    transactions.find_all_by_invoice_id(id)
  end

  def find_customers_for_invoice(id)
    customers.find_by_id(id)
  end

  def find_invoices_for_transaction(id)
    invoices.find_by_id(id)
  end

  def find_customers_for_merchants(id)
    invoices.find_all_by_merchant_id(id).map do |invoice|
      customers.find_by_id(invoice.customer_id)
    end.uniq
  end

  def successful_payment?(id)
    transactions.successful_payment?(id)
  end
end
