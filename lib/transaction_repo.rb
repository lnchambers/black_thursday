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
end
