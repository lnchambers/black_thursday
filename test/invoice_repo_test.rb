require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv'
      })
    @invoices ||= @sales_engine.invoices
  end

  def test_that_all_method_returns_all_invoices
    assert_instance_of Invoice, @invoices.all.first
    assert_equal 40, @invoices.all.count
  end

  def test_that_find_by_id_returns_invoice_by_id
    desired_invoice = @invoices.invoices[1]

    assert_instance_of Invoice, @invoices.find_by_id(1)
    assert_equal desired_invoice, @invoices.find_by_id(1)
  end


end
