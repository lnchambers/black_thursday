require_relative 'test_helper'
require './lib/merchant_repo'

class MerchantRepoTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })
    @merchants = @sales_engine.merchant_repo
  end

  def test_that_it_finds_all_by_price_range
    assert_equal "", merchants.find_all_by_price_in_range(500, 2200)
  end

  def test_that_it

  end

  def test_that_it

  end

  def test_that_it

  end

end
