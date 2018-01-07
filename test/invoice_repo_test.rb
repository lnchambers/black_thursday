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

  def test_that_find_by_id_method_returns_invoice_by_id
    desired_invoice = @invoices.invoices[1]

    assert_instance_of Invoice, @invoices.find_by_id(1)
    assert_equal desired_invoice, @invoices.find_by_id(1)
  end

  def test_find_all_invoice_by_customer_id_method_returns_correct_invoice
    desired_invoice1 = @invoices.invoices[13]
    desired_invoice2 = @invoices.invoices[14]
    desired_invoice3 = @invoices.invoices[15]
    desired_invoices = [desired_invoice1, desired_invoice2, desired_invoice3]

    assert_equal desired_invoices, @invoices.find_all_by_customer_id(3)
    desired_invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end  
  end


end
