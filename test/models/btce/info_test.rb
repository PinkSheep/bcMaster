require 'test_helper'

class InfoTest < ActiveSupport::TestCase
  def setup
    @info = Btce::Info.new
  end
  def teardown
    @info = nil
  end
  test "should return btc_usd ticker" do
    ticker = @info.ticker("btc_usd")
    assert !nil?, "result received"
    assert !ticker['ticker'].nil?, "result contains ticker"
    assert (ticker['ticker'].keys -
      %w(high low avg vol vol_cur last
      buy sell updated server_time)).empty?,
      "attributes of ticker have not changed"
  end
  test "should return btc_usd trades" do
    trades = @info.trades("btc_usd")
    assert !nil?, "result received"
    assert trades.is_a?(Array), "result is an array"
    assert (trades[0].keys -
      %w(date price amount tid price_currency item trade_type )).empty?,
      "attributes of trades have not changed"
  end
  test "should return btc_usd market depth" do
    D = @info.depth("btc_usd").keys
    assert !nil?, "result received"
    C = %w(bids asks)
    assert ((D-C)+(C-D)).empty?,
      "attributes of market depth match"
  end
  test "should return trade fees" do
    fees = @info.fee("btc_ltc")
    assert !nil?, "result received"
    assert !fees
  end
end
