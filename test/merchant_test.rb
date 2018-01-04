require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :repository

  # def setup
  #   repository = stub(repository: "repository")
  #   merchant = Merchant.new({id: "1", name: "Cornelius",
  #                             created_at: "13:02", updated_at: "13:03"}, repository)
  # end

  def test_merchant_exists
    repository = stub(repository: "repository")
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_instance_of Merchant, merchant
  end

  def test_id_is_accurate
    repository = stub(repository: "repository")
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal 1, merchant.id
  end

  def test_name_is_accurate
    repository = stub(repository: "repository")
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal "Cornelius", merchant.name
  end

  def test_created_at_is_accurate
    repository = stub(repository: "repository")
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal "13:02", merchant.created_at
  end

  def test_updated_at_is_accurate
    repository = stub(repository: "repository")
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_equal "13:03", merchant.updated_at
  end

  def test_repository_is_found
    repository = stub(repository: "repository")
    merchant = Merchant.new({id: "1", name: "Cornelius",
                              created_at: "13:02", updated_at: "13:03"}, repository)
    assert_instance_of Mock, merchant.repository
  end

  def test_items_found_by_some_argument
    skip
    item_1 = stub(id: 1)
    item_2 = stub(id: 2)
    item_3 = stub(id: 3)
    item_4 = stub(id: 4)

    assert_equal [item_1, item_2, item_3, item_4], merchant.items
  end

end
