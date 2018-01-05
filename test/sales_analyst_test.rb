require_relative 'test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    sales_engine = mock('this')
    sa = SalesAnalyst.new(sales_engine)
    assert_instance_of SalesAnalyst, sa
  end

  def test_find_total_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 40, sa.total_merchants
  end

  def test_find_total_items
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 40.0, sa.total_items
  end

  def test_find_average_items_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.0, sa.average_items_per_merchant
  end

  def test_find_average_items_per_merchant_stdev
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 0.96, sa.average_items_per_merchant_standard_deviation
  end

  def test_find_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)
    merchants = sales_engine.merchants
    desired_merchant1 = merchants.merchants[1]
    desired_merchant2 = merchants.merchants[5]
    desired_merchant3 = merchants.merchants[8]
    desired_merchant4 = merchants.merchants[10]
    desired_merchant5 = merchants.merchants[14]
    desired_merchant6 = merchants.merchants[27]
    desired_merchant7 = merchants.merchants[31]
    desired_merchant8 = merchants.merchants[32]
    desired_merchant9 = merchants.merchants[35]
    desired_merchant10 = merchants.merchants[36]
    desired_merchant11 = merchants.merchants[38]
    desired_merchant12 = merchants.merchants[40]

    assert_equal [desired_merchant1, desired_merchant2, desired_merchant3,
      desired_merchant4, desired_merchant5, desired_merchant6,
      desired_merchant7, desired_merchant8, desired_merchant9,
      desired_merchant10, desired_merchant11, desired_merchant12],
      sa.merchants_with_high_item_count
  end

  def test_average_item_price_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 18.23, sa.average_item_price_standard_deviation
  end

end
