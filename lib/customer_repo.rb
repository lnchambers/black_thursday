require_relative 'customer'
require_relative 'sales_engine'
require_relative 'create_elements'

class CustomerRepo
  attr_reader :customers

  include CreateElements

  def initialize(data, parent)
    @customers = {}
    create_elements(data).each do |row|
      @customers[row[:id].to_i] = Customer.new(row, self)
    end
    @parent = parent
  end

  def all
    return customers.values
  end

  def find_by_id(id)
    customers[id]
  end

end
