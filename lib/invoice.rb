require 'pry'
require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status].to_sym
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @repository  = repository
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def items
    repository.find_all_items(id)
  end

  def transactions
    repository.find_all_transactions(id)
  end

  def customer
    repository.find_all_customers(customer_id)
  end

  def invoice_items
    repository.find_all_invoice_items(id)
  end

  def invoices
    repository.find_invoice(id)
  end

  def is_paid_in_full?
    if repository.successful_transaction(id) == "success"
      true
    else
      false
    end
  end

  def total_collected
    if is_paid_in_full?
      repository.get_total(id)
    else
      0
    end
  end

  def successful_transaction?
    is_paid_in_full?
  end

  def total
    repository.get_total(id)
  end
end
