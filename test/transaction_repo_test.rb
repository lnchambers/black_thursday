require_relative 'test_helper'
require './lib/transaction_repo'
require './lib/sales_engine'
require './lib/item_repo'

class TransactionRepoTest < MiniTest::Test
  attr_reader :transactions


  def setup
    @sales_engine ||= SalesEngine.from_csv({
      items: 'test/fixtures/item_fixture.csv',
      merchants: 'test/fixtures/merchant_fixture.csv',
      invoices: './test/fixtures/invoice_fixture.csv',
      invoice_items: './test/fixtures/invoice_item_fixture.csv',
      customers: './test/fixtures/customer_fixture.csv',
      transactions: './test/fixtures/transaction_fixture.csv'
      })
    @transactions ||= @sales_engine.transactions
  end

  def test_transaction_repo_attributes
    assert_instance_of TransactionRepo, transactions
    assert_instance_of Hash, transactions.transactions
    assert_instance_of Transaction, transactions.transactions.values.first
    assert_instance_of SalesEngine, transactions.parent
  end
end
