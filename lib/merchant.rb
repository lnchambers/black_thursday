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

  def revenue
    invoices.sum do |invoice|
      invoice.total_collected
    end
  end
end
