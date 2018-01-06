require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    sales_engine = SalesEngine.new({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv'
      })

    assert_instance_of SalesEngine, sales_engine
  end

end
