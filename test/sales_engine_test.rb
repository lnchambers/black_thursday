require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    sales_engine = SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })

    assert_instance_of SalesEngine, sales_engine
  end

end
