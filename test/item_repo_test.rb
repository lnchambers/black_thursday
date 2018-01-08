require './test/test_helper'
require './lib/item_repo'
require './lib/sales_engine'
require './lib/merchant_repo'

class ItemRepoTest < Minitest::Test

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @items ||= @sales_engine.items
  end

  def test_repo_finds_all_items
    assert_equal 40, @items.all.count
  end

  def test_find_merchants_by_merchant_id
    desired_merchant1 = @sales_engine.merchants.merchants[1]
    desired_merchant2 = @sales_engine.merchants.merchants[2]

    assert_equal desired_merchant1, @items.find_merchant(1)
    assert_equal desired_merchant2, @items.find_merchant(2)
  end

  def test_find_items_by_item_id
    desired_item1 = @items.items[1]
    desired_item2 = @items.items[2]

    assert_instance_of Item, @items.find_by_id(1)
    assert_instance_of Item, @items.find_by_id(2)
    assert_equal desired_item1, @items.find_by_id(1)
    assert_equal desired_item2, @items.find_by_id(2)
  end

  def test_find_by_name
    desired_item1 = @items.items[1]

    assert_equal desired_item1, @items.find_by_name("Tiny Toaster")
  end

  def test_find_by_item_description
    desired_item1 = @items.items[14]

    assert_equal [desired_item1], @items.find_all_with_description("oh my full!")
  end

  def test_find_all_by_price
    desired_item1 = @items.items[1]
    desired_item2 = @items.items[3]
    desired_item3 = @items.items[37]
    desired_items = [desired_item1, desired_item2, desired_item3]

    assert_equal desired_items, @items.find_all_by_price((0.7000).round(2))
  end

  def test_find_all_by_price_in_range
    skip # MUST come back to but is very annoying to test.
    desired_item1 = @items.items[0]
    desired_item2 = @items.items[2]
    desired_item3 = @items.items[9]
    range = (((0.6900).round(2))..((0.7000).round(2)))

    assert_equal [desired_item1, desired_item2,
       desired_item3], @items.find_all_by_price_in_range(range)
  end

  def test_find_all_by_merchant_id
    desired_item1 = @items.items[2]
    desired_item2 = @items.items[38]

    assert_equal [desired_item1, desired_item2], @items.find_all_by_merchant_id(1)
  end

end
