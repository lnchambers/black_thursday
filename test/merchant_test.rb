require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    repository = mock('repository')
    data = {id: "1",
            name: "Cornelius",
            created_at: "13:02",
            updated_at: "13:03"}
    @merchant = Merchant.new(data, repository)
  end

  def test_merchant_attributes
    assert_instance_of Merchant, @merchant
    assert_equal 1, @merchant.id
    assert_equal "Cornelius", @merchant.name
    assert_equal Time.parse("13:02"), @merchant.created_at
    assert_equal Time.parse("13:03"), @merchant.updated_at
  end

end
