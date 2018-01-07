require_relative 'test_helper'
require './lib/customer'
require './lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :customer

  def setup
    repository = mock('repository')
    data = {id: "3",
            first_name: "Bob",
            last_name: "Burger",
            created_at: "13:03",
            updated_at: "13:05"}
    @customer = Customer.new(data, repository)
  end

  def test_customer_attributes
    assert_instance_of Customer, @customer
    assert_equal 3, @customer.id
    assert_equal "Bob", @customer.first_name
    assert_equal "Burger", @customer.last_name
    assert_equal Time.parse("13:03"), @customer.created_at
    assert_equal Time.parse("13:05"), @customer.updated_at
  end

end
