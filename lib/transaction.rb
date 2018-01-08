  require 'pry'
require 'time'
require_relative 'transaction_repo'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id                          = data[:id].to_i
    @invoice_id                  = data[:invoice_id].to_i
    @credit_card_number          = data[:credit_card_number].to_i
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result                      = data[:result]
    @created_at                  = Time.parse(data[:created_at])
    @updated_at                  = Time.parse(data[:updated_at])
    @repository                  = repository
  end

  def find_by_id(id)
    repository.find_by_id(id)
  end

  def find_all_by_invoice_id(invoice_id)
    repository.find_all_by_invoice_id(invoice_id)
  end

  def invoice
     repository.find_invoices_for_transaction(invoice_id)
  end

end
