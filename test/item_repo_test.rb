require './test/test_helper'
require './lib/item_repo'
require './lib/sales_engine'
require './lib/merchant_repo'

class ItemRepoTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })
    @items = @sales_engine.items
  end

  def test_repo_finds_all_items
    assert_equal 40, @items.all.count
  end

  def test_find_by_item_id
    desired_item1 = @items.items[0]
    desired_item2 = @items.items[1]

    assert_instance_of Item, @items.find_by_id(1)
    assert_instance_of Item, @items.find_by_id(2)
    assert_equal desired_item1, @items.find_by_id(1)
    assert_equal desired_item2, @items.find_by_id(2)
  end

  def test_find_by_name
    desired_item1 = @items.items[13]

    assert_equal desired_item1, @items.find_by_name("coffee pot")
  end

  def test_find_by_item_description
    desired_item1 = @items.items[13]

    assert_equal [desired_item1], @items.find_all_with_description("oh my full!")
  end

end
