require './lib/customer_repo'
require './lib/sales_engine'
require_relative 'test_helper'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customers

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @customers ||= @sales_engine.customers
  end

  def test_all_returns_array_of_customer_instances
    assert_instance_of Array, customers.all
    assert_instance_of Customer, customers.all.first
    assert_equal 40, customers.all.count
  end

  def test_find_by_id_returns_correct_customer
    assert_nil customers.find_by_id(99999)

    desired_customer = customers.customers[2]

    assert_instance_of Customer, customers.find_by_id(2)
    assert_equal desired_customer, customers.find_by_id(2)
  end

end
