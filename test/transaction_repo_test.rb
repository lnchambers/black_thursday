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

  def test_all_retrives_all_instances_of_invoice_items
    assert_equal 40, transactions.all.count
    transactions.transactions.each do |transaction|
      assert_instance_of Transaction, transaction[1]
    end
  end

  def test_find_by_id_returns_correct_transaction
    assert_nil transactions.find_by_id("jenkins")

    desired_transaction1 = transactions.transactions[1]

    assert_equal desired_transaction1, transactions.find_by_id(1)
  end

  def test_find_all_by_invoice_id_returns_correct_transactions
    assert_equal [], transactions.find_all_by_invoice_id("kelly jjonesss")

    desired_transaction1 = transactions.transactions[3]
    desired_transaction2 = transactions.transactions[9]
    desired_transaction3 = transactions.transactions[15]
    desired_transaction4 = transactions.transactions[18]
    desired_transactions = [desired_transaction1, desired_transaction2,
                            desired_transaction3, desired_transaction4]

    assert_equal desired_transactions, transactions.find_all_by_invoice_id(2)
  end

  def test_find_all_by_credit_card_number_returns_correct_transactions
    assert_equal [], transactions.find_all_by_credit_card_number(:credit_card_number)

    desired_transaction1 = transactions.transactions[1]
    desired_transaction2 = transactions.transactions[2]
    desired_transactions = [desired_transaction1, desired_transaction2]

    assert_equal desired_transactions, transactions.find_all_by_credit_card_number(4068631943231473)
  end

  def test_successful_payment_tells_us_true_or_false_on_payments
    refute transactions.successful_payment?(10)
    assert transactions.successful_payment?(2)
    refute transactions.successful_payment?('thisisnotanumber')
  end

  def test_find_all_by_result
    assert_instance_of Array, transactions.find_all_by_result("success")
    assert_instance_of Array, transactions.find_all_by_result("failed")
    assert_instance_of Array, transactions.find_all_by_result("gobble")
    assert_equal [], transactions.find_all_by_result("gobble")
    assert_equal 0, transactions.find_all_by_result("gobble").count
    assert_equal 32, transactions.find_all_by_result("success").count
    assert_equal 8, transactions.find_all_by_result("failed").count
  end

  def test_find_invoices_for_transaction
    assert_instance_of Invoice, transactions.find_invoices_for_transaction(1)
    assert_equal 1, transactions.find_invoices_for_transaction(1).id
  end
end
