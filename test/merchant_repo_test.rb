require_relative 'test_helper'
require './lib/merchant_repo'
require './lib/sales_engine'
require './lib/item_repo'

class MerchantRepoTest < MiniTest::Test

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      :invoices  => './test/fixtures/invoice_fixture.csv'
      })
    @merchants = @sales_engine.merchants
  end

  def test_find_merchant_by_id
    desired_merchant1 = @merchants.merchants[1]
    assert_equal desired_merchant1, @merchants.find_by_id(1)
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
    desired_item1 = @sales_engine.items.items[1]
    desired_item2 = @sales_engine.items.items[16]
    desired_item3 = @sales_engine.items.items[34]
    assert_equal [desired_item1, desired_item2, desired_item3], @merchants.find_item_by_merchant_id(36)
  end
end
