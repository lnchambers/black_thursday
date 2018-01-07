require_relative 'customer'
require_relative 'sales_engine'
require_relative 'create_elements'

class CustomerRepo
  attr_reader :data,
              :parent

  def initialize(data, parent)

  end

end
