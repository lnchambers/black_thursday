require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({id: "1", name: "Brian", description: "What what", unit_price: 5000,
             merchant_id: 123, created_at: "13:02", updated_at: "13:03"})
  end

  def test_item_exists
    assert_instance_of Item, @item
  end

  def test_id_is_accurate
    assert_equal "1", @item.id
  end

  def test_name_is_accurate
    assert_equal "Brian", @item.name
  end

  def test_description_is_accurate
    assert_equal "What what", @item.description
  end

  def test_unit_price_is_accurate
    assert_equal "50.00", @item.unit_price
  end

  def test_merchant_id_is_accurate
    assert_equal "123", @item.merchant_id
  end

  def test_created_at_is_accurate
    assert_equal "13:02", @item.created_at
  end

  def test_updated_at_is_accurate
    assert_equal "13:03", @item.updated_at
  end

  def test_unit_price_to_dollars_returns_a_dollar_amount
    assert_equal 50.05, @item.unit_price_to_dollars
  end

end
