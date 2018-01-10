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
    assert_instance_of Invoice, @invoice
    assert_equal 1, @invoice.id
    assert_equal 6, @invoice.merchant_id
    assert_equal :shipped, @invoice.status
    assert_equal Time.parse("13:03"), @invoice.created_at
    assert_equal Time.parse("13:04"), @invoice.updated_at
  end

end
