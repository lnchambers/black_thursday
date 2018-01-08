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

  def test_find_all_by_first_name_returns_correct_customers_and_is_case_insensitive
    assert_equal [], customers.find_all_by_first_name("hhHHhahahahahahahhhhh")

    desired_customer1 = customers.customers[1]
    desired_customer2 = customers.customers[2]
    desired_customers = [desired_customer1, desired_customer2]

    assert_instance_of Array, customers.find_all_by_first_name("Joey")
    assert_equal desired_customers, customers.find_all_by_first_name("Joe")
  end

  def test_find_all_by_last_name_returns_correct_customers_and_is_case_insensitive
    assert_equal [], customers.find_all_by_last_name("hhHHhahahahahahahhhhh")

    desired_customer1 = customers.customers[1]
    desired_customer2 = customers.customers[3]
    desired_customer3 = customers.customers[13]
    desired_customer4 = customers.customers[27]
    desired_customers_normal   = [desired_customer1, desired_customer2,
                                  desired_customer3]
    desired_customers_edgecase = [desired_customer1, desired_customer2,
                                  desired_customer3, desired_customer4]

    assert_instance_of Array, customers.find_all_by_last_name("Toy")
    assert_equal desired_customers_normal, customers.find_all_by_last_name("Toy")
    assert_equal desired_customers_normal, customers.find_all_by_last_name("OY")
    assert_equal desired_customers_edgecase, customers.find_all_by_last_name("To")
  end
end
