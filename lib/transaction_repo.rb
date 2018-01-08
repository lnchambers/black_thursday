require_relative 'transaction'
require_relative 'sales_engine'
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

  def successful_payment?(invoice_id)
     find_all_by_invoice_id(invoice_id).find do |transaction|
      if transaction.result == "success"
        return true
      else
        return false
      end
    end
  end

  def find_all_by_result(result)
    transactions.values.find_all do |transaction|
      transaction.result == result
    end
  end

def inspect
  "#<#{self.class} #{transactions.size} rows>"
end
end
