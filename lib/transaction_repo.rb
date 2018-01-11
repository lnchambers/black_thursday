require_relative 'transaction'
require_relative 'create_elements'

class TransactionRepo
  attr_reader :transactions,
              :parent

  include CreateElements

  def initialize(data, parent)
    @transactions = {}
    create_elements(data).each do |row|
      @transactions[row[:id].to_i] = Transaction.new(row, self)
    end
    @parent = parent
  end

  def all
    transactions.values
  end

  def find_by_id(id)
    transactions[id]
  end

  def find_all_by_invoice_id(id)
    transactions.values.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    transactions.values.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def successful_payment?(id)
     find_all_by_invoice_id(id).any? do |transaction|
      transaction.result == "success"
    end
  end

  def successful_transactions
    transactions.values.reduce({}) do |result, transaction|
      if transaction.result.include? "success"
        result.merge({transaction.invoice_id => transaction.result})
      else
        result
      end
    end
  end

  def find_all_by_result(result)
    transactions.values.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoices_for_transaction(id)
    parent.find_invoices_for_transaction(id)
  end

  def inspect
    "#<#{self.class} #{transactions.size} rows>"
  end
end
