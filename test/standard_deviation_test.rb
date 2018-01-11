require './test/test_helper'
require './lib/standard_deviation'

class StandardDeviationTest < Minitest::Test
  include StandardDeviation

  def test_standard_deviation_mean
    assert_equal 15, mean(150, 10)
  end
end
