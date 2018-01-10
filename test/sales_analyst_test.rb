require './test/test_helper'
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

  def test_average_average_price_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 0.155e2, sa.average_average_price_per_merchant
  end

  def test_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.75, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)
    desired_merchant1 = sales_engine.merchants.merchants[9]
    desired_merchant2 = sales_engine.merchants.merchants[20]
    desired_merchants = [desired_merchant1, desired_merchant2]

    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_equal desired_merchants, sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.bottom_merchants_by_invoice_count
    assert_equal [], sa.bottom_merchants_by_invoice_count
  end

  def test_total_with_status
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.total_with_status(:pending)
    assert_equal 13, sa.total_with_status(:pending).count
    assert_equal 25, sa.total_with_status(:shipped).count
    assert_equal 2, sa.total_with_status(:returned).count
  end

  def test_top_days_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.top_days_by_invoice_count
    assert_equal ["Saturday"], sa.top_days_by_invoice_count
  end

  def test_get_invoices_for_revenue_by_date
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    date = Time.parse("2009-02-07 00:00:00 -0700")
    assert_instance_of BigDecimal, sa.total_revenue_by_date(date)
    assert_equal 0.2106777e5, sa.total_revenue_by_date(date)
  end

  def test_get_merchants_with_pending_invoices
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.merchants_with_pending_invoices
    assert_equal 10, sa.merchants_with_pending_invoices.count
  end

  def test_find_merchants_with_only_one_item
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.merchants_with_only_one_item
    assert_equal 13, sa.merchants_with_only_one_item.count
  end

  def test_find_merchants_with_only_one_item_registered_in_month
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.merchants_with_only_one_item_registered_in_month("January")
    assert_equal 4, sa.merchants_with_only_one_item_registered_in_month("January").count
  end

  def test_most_sold_item_for_merchant_with_id
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Array, sa.most_sold_item_for_merchant(2)
    assert_equal 1, sa.most_sold_item_for_merchant(3).count
  end

  def test_best_item_for_merchant_with_id
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)
    desired_item = sales_engine.items.items[2]

    assert_instance_of Item, sa.best_item_for_merchant(3)
    assert_equal desired_item, sa.best_item_for_merchant(3)
  end

  def test_pair_merchants_with_revenue
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of Merchant, sa.pair_merchants_with_revenue[0][0]
    assert_equal 0.5651551e5, sa.pair_merchants_with_revenue[0][1]
  end

  def test_revenue_for_merchant
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 0.5651551e5, sa.revenue_by_merchant(1)
  end
end
