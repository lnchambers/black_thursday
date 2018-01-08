require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader :transaction

  def setup
    repository = mock('repository')
    data = {id: "1",
            invoice_id: "1",
            credit_card_number: "1234567891234567",
            credit_card_expiration_date: "1220",
            result: "Paid",
            created_at: "13:02",
            updated_at: "13:03"}
    @transaction = Transaction.new(data, repository)
  end

  def test_transaction_attributes
    assert_instance_of Transaction, transaction
    assert_equal 1, transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 1234567891234567, transaction.credit_card_number
    assert_equal "1220", transaction.credit_card_expiration_date
    assert_equal "Paid", transaction.result
    assert_equal Time.parse("13:02"), transaction.created_at
    assert_equal Time.parse("13:03"), transaction.updated_at
  end
end
