require './test/test_helper'
require './lib/invoice_repo'
require './lib/sales_engine'

class InvoiceItemRepoTest < Minitest::Test
  attr_reader :invoice_items
  
  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @invoice_items ||= @sales_engine.invoice_items
  end

  def test_all_method_returns_all_invoice_items
    assert_instance_of Array, invoice_items.all
    assert_instance_of InvoiceItem, invoice_items.all.first
    assert_equal 40, invoice_items.all.count
  end

  def test_find_by_id_returns_correct_invoice_item
    assert_nil invoice_items.find_by_id(2999)

    desired_item_invoice = invoice_items.invoice_items[1]

    assert_equal desired_item_invoice, invoice_items.find_by_id(1)
  end

  def test_find_all_by_item_id_returns_correct_invoice_item
    assert_equal [], invoice_items.find_all_by_item_id(99999)

    desired_item_invoice1 = invoice_items.invoice_items[33]
    desired_item_invoice2 = invoice_items.invoice_items[34]
    desired_item_invoice3 = invoice_items.invoice_items[38]
    desired_item_invoices = [desired_item_invoice1, desired_item_invoice2,
                            desired_item_invoice3]

    assert_instance_of Array, invoice_items.find_all_by_item_id(5)
    assert_equal desired_item_invoices, invoice_items.find_all_by_item_id(5)
  end

  def test_find_all_by_invoice_id_returns_correct_invoice_item
    assert_equal [], invoice_items.find_all_by_invoice_id(99999)

    desired_item_invoice1 = invoice_items.invoice_items[38]
    desired_item_invoice2 = invoice_items.invoice_items[39]
    desired_item_invoices = [desired_item_invoice1, desired_item_invoice2]

    assert_instance_of Array, invoice_items.find_all_by_invoice_id(8)
    assert_equal desired_item_invoices, invoice_items.find_all_by_invoice_id(8)
  end

end
