require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_find_invoice_items
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    desired_invoice_item = sales_engine.invoice_items.invoice_items[2]

    assert_nil sales_engine.find_invoice_items("thisisanids")
    assert_equal desired_invoice_item, sales_engine.find_invoice_items(2)
  end

  def test_find_customers_for_invoice
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    desired_customer = sales_engine.customers.customers[2]

    assert_nil sales_engine.find_customers_for_invoice(:two)
    assert_nil sales_engine.find_customers_for_invoice(":two")
    assert_equal desired_customer, sales_engine.find_customers_for_invoice(2)
  end

  def test_find_customers_for_merchants
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    desired_customer = sales_engine.customers.customers[1]

    assert_instance_of Array, sales_engine.find_customers_for_merchants(:five)
    assert_equal [], sales_engine.find_customers_for_merchants(:five)
    assert_equal [], sales_engine.find_customers_for_merchants("five")
    assert_equal [desired_customer], sales_engine.find_customers_for_merchants(5)
  end
end
