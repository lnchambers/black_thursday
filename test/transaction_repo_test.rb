require_relative 'test_helper'
require './lib/transaction_repo'
require './lib/sales_engine'
require './lib/item_repo'

class TransactionRepoTest < MiniTest::Test
  attr_reader :transaction

  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchant: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @transaction = @sales_engine.transaction
  end

  def test_transaction_repo_attributes
    assert_instance_of Hash, transaction
    assert_instance_of Transaction, transaction.values.first
    assert_instance_of SalesEngine, transactions.parent
  end
end
