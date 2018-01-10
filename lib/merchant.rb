require 'pry'
require 'time'

class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @repository = repository
  end

  def items
    repository.find_item(id)
  end

  def invoices
    repository.find_invoice(id)
  end

  def customers
    repository.find_customers(id)
  end

  def calculate_revenue
    invoices.sum do |invoice|
      if invoice.is_paid_in_full?
        invoice.total
      else
        0
      end
    end
  end

  def revenue
    (revenue ||= calculate_revenue)
  end
end
