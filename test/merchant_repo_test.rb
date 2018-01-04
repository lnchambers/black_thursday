require_relative 'test_helper'
require './lib/merchant_repo'
require './lib/sales_engine'

class MerchantRepoTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })
    @merchants = @sales_engine.merchants
  end

  def test_find_merchant_by_id
    desired_merchant1 = @merchants.merchants["1"]

    assert_equal [desired_merchant1], @merchants.find_by_id(1)
  end

  def test_find_merchant_by_name
    desired_merchant1 = @merchants.merchants[7]

    assert_equal desired_merchant1, @merchants.find_by_name("jejum")
  end

  def test_find_all_merchants_by_name
    merchant = @merchants.find_all_by_name("Uniford")

    assert_equal 2, merchant.count
    assert_equal "Uniford", merchant[0].name
    assert_equal "Uniford", merchant[1].name
  end

  def test_find_item_by_merch_id
    assert_instance_of Item, @merchants.find_item_by_merchant_id("1")

  end
end
