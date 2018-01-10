require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    repository = mock('repository')
    data = {id: "1",
            name: "Brian",
            description: "What what",
            unit_price: 5000,
            merchant_id: 123,
            created_at: "13:03",
            updated_at: "13:02"}
    @item = Item.new(data, repository)
  end

  def test_item_attributes
    assert_instance_of Item, @item
    assert_equal 1, @item.id
    assert_equal "Brian", @item.name
    assert_equal "What what", @item.description
    assert_equal (BigDecimal.new(5000) / 100), @item.unit_price
    assert_equal 123, @item.merchant_id
    assert_equal Time.parse("13:03"), @item.created_at
    assert_equal Time.parse("13:02"), @item.updated_at
  end

  def test_unit_price_to_dollars_returns_dollar_amount
    assert_equal 50.0, @item.unit_price_to_dollars
  end
end
