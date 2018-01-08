require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @invoices ||= @sales_engine.invoices
  end

  def test_that_all_method_returns_all_invoices
    assert_instance_of Array, @invoices.all
    assert_instance_of Invoice, @invoices.all.first
    assert_equal 40, @invoices.all.count
  end

  def test_that_find_by_id_method_returns_invoice_by_id
    desired_invoice = @invoices.invoices[1]

    assert_instance_of Invoice, @invoices.find_by_id(1)
    assert_equal desired_invoice, @invoices.find_by_id(1)
  end

  def test_find_all_invoice_by_customer_id_method_returns_correct_invoices
    desired_invoice1 = @invoices.invoices[13]
    desired_invoice2 = @invoices.invoices[14]
    desired_invoice3 = @invoices.invoices[15]
    desired_invoices = [desired_invoice1, desired_invoice2, desired_invoice3]

    assert_equal desired_invoices, @invoices.find_all_by_customer_id(3)
    desired_invoices.each do |invoice|
      assert_instance_of Invoice, invoice
    end
  end

  def test_find_all_by_merchant_id_method_returns_correct_invoices
    desired_invoice1 = @invoices.invoices[4]
    desired_invoice2 = @invoices.invoices[11]
    desired_invoices = [desired_invoice1, desired_invoice2]

    assert_equal desired_invoices, @invoices.find_all_by_merchant_id(3)
  end

  def test_find_all_by_status_returns_correct_invoices
    desired_invoice1 = @invoices.invoices[1]
    desired_invoice2 = @invoices.invoices[4]
    desired_invoice3 = @invoices.invoices[5]
    desired_invoice4 = @invoices.invoices[6]
    desired_invoice5 = @invoices.invoices[7]
    desired_invoice6 = @invoices.invoices[10]
    desired_invoice7 = @invoices.invoices[11]
    desired_invoice8 = @invoices.invoices[14]
    desired_invoice9 = @invoices.invoices[17]
    desired_invoice10 = @invoices.invoices[23]
    desired_invoice11 = @invoices.invoices[30]
    desired_invoice12 = @invoices.invoices[35]
    desired_invoice13 = @invoices.invoices[38]
    desired_invoices = [desired_invoice1, desired_invoice2, desired_invoice3,
    desired_invoice4, desired_invoice5, desired_invoice6, desired_invoice7,
    desired_invoice8, desired_invoice9, desired_invoice10, desired_invoice11,
    desired_invoice12, desired_invoice13]

    assert_equal desired_invoices, @invoices.find_all_by_status(:pending)
  end

  def test_find_merchant_returns_correct_merchant
    desired_merchant = @sales_engine.merchants.merchants[1]

    assert_equal desired_merchant, @invoices.find_merchant(1)
  end
end
