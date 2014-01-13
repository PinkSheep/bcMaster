require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  def setup
    @trade = Btce::Trade.new('key', 'secret')
  end
  def teardown
    @info = nil
  end
  test "should return account info" do
    assert_not_nil @trade.getInfo
  end
end
