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

    assert_equal 1.0, sa.average_items_per_merchant_standard_deviation
  end

  def test_average_item_price_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
    })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal "", sa.average_item_price_standard_deviation
  end

end
