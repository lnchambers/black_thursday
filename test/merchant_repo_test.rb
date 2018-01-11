require './test/test_helper'
require './lib/merchant_repo'
require './lib/sales_engine'
require './lib/item_repo'

class MerchantRepoTest < MiniTest::Test

  def merchants
    @merchants
  end

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @merchants = @sales_engine.merchants
  end

  def test_that_all_method_returns_all_merchant_instances
    assert_instance_of Array, merchants.all
    assert_equal 40, merchants.all.count
    assert_instance_of SalesEngine, merchants.parent
    merchants.merchants.each do |merchant|
      assert_instance_of Merchant, merchant[1]
    end
  end

  def test_find_merchant_by_id
    assert_nil merchants.find_by_id("4/4/4/4")

    desired_merchant1 = merchants.merchants[1]

    assert_equal desired_merchant1, merchants.find_by_id(1)
  end

  def test_find_merchant_by_name
    assert_nil merchants.find_by_name(77777)

    desired_merchant1 = merchants.merchants[7]

    assert_equal desired_merchant1, merchants.find_by_name("jejum")
  end

  def test_find_all_merchants_by_name
    assert_equal [], merchants.find_all_by_name(88)

    merchant = merchants.find_all_by_name("Uniford")

    assert_equal 2, merchant.count
    assert_equal "Uniford", merchant[0].name
    assert_equal "Uniford", merchant[1].name
  end

  def test_find_item_by_merch_id
    assert_equal [], merchants.find_item_by_merchant_id("id")

    desired_item1 = @sales_engine.items.items[1]
    desired_item2 = @sales_engine.items.items[16]
    desired_item3 = @sales_engine.items.items[34]

    assert_equal [desired_item1, desired_item2, desired_item3], merchants.find_item_by_merchant_id(36)
  end

  def test_find_invoice
    assert_instance_of Array, merchants.find_invoice(99)
    assert_equal [], merchants.find_invoice(:symbol)

    desired_invoice1 = @sales_engine.invoices.invoices[1]
    desired_invoice2 = @sales_engine.invoices.invoices[2]
    desired_invoice3 = @sales_engine.invoices.invoices[3]

    assert_equal [desired_invoice1, desired_invoice2,
                  desired_invoice3], merchants.find_invoice(1)
  end

  def test_find_customers
    assert_instance_of Array, merchants.find_customers(2)
    assert_equal [], merchants.find_customers("this is bad input")

    desired_customer1 = @sales_engine.customers.customers[1]
    desired_customer2 = @sales_engine.customers.customers[2]
    desired_customers = [desired_customer1, desired_customer2]

    assert_equal desired_customers, merchants.find_customers(8)
  end

  def test_find_all_invoices_returns_all_invoice_objects
    assert_instance_of Array, merchants.find_all_invoices
    merchants.find_all_invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end
  end

  def test_get_revenue
    assert_instance_of Array, merchants.get_revenue
    assert_instance_of Merchant, merchants.get_revenue[0][0]
    assert_instance_of BigDecimal, merchants.get_revenue[0][1]
    assert_equal 40, merchants.get_revenue.count
  end
end
