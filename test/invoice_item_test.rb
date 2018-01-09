require './test/test_helper'
require './lib/invoice_item'
require 'time'

class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item

  def setup
    repository = mock('repository')
    data = {id: "1",
            item_id: "1",
            invoice_id: "1",
            quantity: "1",
            unit_price: "2000",
            created_at: "13:03",
            updated_at: "13:04"}
    @invoice_item = InvoiceItem.new(data, repository)
  end

  def test_invoice_item_attributes
    assert_instance_of InvoiceItem, invoice_item
    assert_equal 1, invoice_item.id
    assert_equal 1, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 1, invoice_item.quantity
    assert_equal (BigDecimal.new(2000) / 100), invoice_item.unit_price
    assert_equal Time.parse("13:03"), invoice_item.created_at
    assert_equal Time.parse("13:04"), invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 20.00, invoice_item.unit_price_to_dollars
  end

end
