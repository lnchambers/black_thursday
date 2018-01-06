require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      invoices: 'test/fixtures/invoice_fixture.csv'
      })
    @merchants = @sales_engine.invoices
  end

  def test_it_exists
    invoice_repo = InvoiceRepo.new

    assert_instance_of InvoiceRepo, invoice_repo
  end

  def test_all_returns_all_invoices
    invoice_repo = InvoiceRepo.new

    assert_equal 40, invoice_repo.all.count
  end

  def test_find_by_id
    invoice_repo = InvoiceRepo.new

    assert_nil invoice_repo.find_by_id(9999999999)
  end

end
