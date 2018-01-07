require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'create_elements'

class TransactionRepo
<<<<<<< HEAD
  attr_reader :transactions,
              :parent
=======
>>>>>>> cbeaf56777549f21de472390c769ebd16c0020b3

  def initialize(data, parent)
    @transactions = {}
    create_elements.each do |row|
      @transactions[row[:id].to_i] = Transaction.new(data, self)
    end
    @parent = parent
  end

<<<<<<< HEAD
  def all
    transactions.values
  end

=======
>>>>>>> cbeaf56777549f21de472390c769ebd16c0020b3
end
