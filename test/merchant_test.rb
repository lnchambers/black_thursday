require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :repository

  def test_merchant_exists
    repository = mock('repository')
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_instance_of Merchant, merchant
  end

  def test_id_is_accurate
    repository = mock('repository')
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal 1, merchant.id
  end

  def test_name_is_accurate
    repository = mock('repository')
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal "Cornelius", merchant.name
  end

  def test_created_at_is_accurate
    repository = mock('repository')
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal "13:02", merchant.created_at
  end

  def test_updated_at_is_accurate
    repository = mock('repository')
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal "13:03", merchant.updated_at
  end

end
