require_relative 'test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    sales_engine = mock('sales_engine')
    sa = SalesAnalyst.new(sales_engine)
    assert_instance_of SalesAnalyst, sa
  end

  def test_find_total_merchants
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 40, sa.total_merchants
  end

  def test_find_total_items
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 40.0, sa.total_items
  end

  def test_find_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.0, sa.average_items_per_merchant
  end

  def test_find_average_items_per_merchant_stdev
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 0.96, sa.average_items_per_merchant_standard_deviation
  end

  def test_find_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)
    merchants = sales_engine.merchants.merchants
    desired_merchant1 = merchants[1]
    desired_merchant2 = merchants[5]
    desired_merchant3 = merchants[8]
    desired_merchant4 = merchants[10]
    desired_merchant5 = merchants[14]
    desired_merchant6 = merchants[27]
    desired_merchant7 = merchants[31]
    desired_merchant8 = merchants[32]
    desired_merchant9 = merchants[35]
    desired_merchant10 = merchants[36]
    desired_merchant11 = merchants[38]
    desired_merchant12 = merchants[40]

    assert_equal [desired_merchant1, desired_merchant2, desired_merchant3,
      desired_merchant4, desired_merchant5, desired_merchant6,
      desired_merchant7, desired_merchant8, desired_merchant9,
      desired_merchant10, desired_merchant11, desired_merchant12],
      sa.merchants_with_high_item_count
  end

  def test_average_item_price_standard_deviation
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 30.43, sa.average_item_price_standard_deviation
  end

  def test_find_golden_items
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)
    item = sales_engine.items.items
    desired_item1 = item[12]

    assert_equal [desired_item1], sa.golden_items
  end

  def test_average_item_price_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 0.155e2, sa.average_item_price_for_merchant(1)
  end

  def test_sales_analyst_total_revenue_by_date

  end

end
