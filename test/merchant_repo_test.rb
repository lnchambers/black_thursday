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
    assert_equal desired_merchant1, @merchants.find_by_id(1)
  end

  def test_find_merchant_by_name
    skip
    merchant = @merchants.find_by_name("jejum")

    assert_instance_of Merchant, merchant
    assert_equal "jejum", merchant.name
  end

  def test_find_all_merchants_by_name
    skip
    merchant = @merchants.find_all_by_name(" Uniford")

    assert_equal 2, merchant.count
    assert_equal " Uniford", merchant[0].name
    assert_equal " Uniford", merchant[1].name
  end

  def test_that_it_finds_all_by_price_range
    skip
    assert_equal "", merchants.find_all_by_price_in_range(500, 2200)
  end

  def test_that_it
    skip

  end

  def test_that_it
    skip

  end

end
