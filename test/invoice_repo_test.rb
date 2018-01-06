require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test

  # def setup
  #   @sales_engine ||= SalesEngine.from_csv({
  #     items: 'test/fixtures/item_fixture.csv',
  #     merchants: 'test/fixtures/merchant_fixture.csv',
  #     invoices: 'test/fixtures/invoice_fixture.csv'
  #     })
  #   @invoices = @sales_engine.invoices
  # end

  def test_it_exists
    assert_instance_of InvoiceRepo, @invoices
  end

  def test_invoice_repo_all
    assert_equal "", @invoices.all
  end

end
