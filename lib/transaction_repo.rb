require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'create_elements'

class TransactionRepo
  attr_reader :transactions,
              :parent

  def initialize(data, parent)
    @transactions = {}
    create_elements.each do |row|
      @transactions[row[:id].to_i] = Transaction.new(data, self)
    end
    @parent = parent
  end

  def all
    transactions.values
  end

end
