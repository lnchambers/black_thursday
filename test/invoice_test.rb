require './test/test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def invoice
    @invoice
  end

  def setup
    repository = mock('repository')
    data = {id: 1,
            customer_id: 1,
            merchant_id: 6,
            status: "shipped",
            created_at: "13:03",
            updated_at: "13:04"}
    @invoice = Invoice.new(data, repository)
  end

  def test_invoice_attributes
    assert_instance_of Invoice, invoice
    assert_equal 1, invoice.id
    assert_equal 6, invoice.merchant_id
    assert_equal :shipped, invoice.status
    assert_equal Time.parse("13:03"), invoice.created_at
    assert_equal Time.parse("13:04"), invoice.updated_at
  end

  def test_can_find_merchant_by_merchant_id
    invoice.repository.stubs(:find_merchant).with(6).returns(true)

    assert invoice.merchant
  end

  def test_can_find_item_by_item_id
    invoice.repository.stubs(:find_all_items).with(1).returns(true)

    assert invoice.items
  end

  def test_can_find_transaction_by_id
    invoice.repository.stubs(:find_all_transactions).with(1).returns(true)

    assert invoice.transactions
  end

  def test_can_find_customer_by_id
    invoice.repository.stubs(:find_all_customers).with(1).returns(true)

    assert invoice.customer
  end

  def test_total_invoice_items
    invoice.repository.stubs(:find_all_invoice_items).with(1).returns(true)

    assert invoice.invoice_items
  end

end
