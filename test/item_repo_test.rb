require './test/test_helper'
require './lib/item_repo'
require './lib/sales_engine'
require './lib/merchant_repo'

class ItemRepoTest < Minitest::Test

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })
    @items = @sales_engine.items
  end

  def test_repo_finds_all_items
    assert_equal 40, @items.all.count
  end

  def test_find_by_item_id
    desired_item1 = @items.items["1"]
    desired_item2 = @items.items["2"]

    assert_instance_of Item, @items.find_by_id(1)
    assert_instance_of Item, @items.find_by_id(2)
    assert_equal desired_item1, @items.find_by_id(1)
    assert_equal desired_item2, @items.find_by_id(2)
  end

  def test_find_by_name
    desired_item1 = @items.items["1"]

    assert_equal [desired_item1], @items.find_by_name("Tiny Toaster")
  end

  def test_find_by_item_description
    desired_item1 = @items.items["14"]

    assert_equal [desired_item1], @items.find_all_with_description("oh my full!")
  end

  def test_find_all_by_price
    desired_item1 = @items.items["2"]
    desired_item2 = @items.items["17"]

    assert_equal [desired_item1, desired_item2], @items.find_all_by_price(900)
  end

  def test_find_all_by_unit_prince_in_range
    skip
    desired_item1 = @items.items[0]
    desired_item2 = @items.items[2]
    desired_item3 = @items.items[9]

    assert_equal [desired_item1, desired_item2,
       desired_item3], @items.find_all_by_unit_price_in_range(6900, 7000)
  end

end
