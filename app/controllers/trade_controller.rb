class TradeController < ApplicationController
  def index
    trade = session_trade_object
    if !trade.nil? && (info = trade.getInfo)["success"] == 1
      @funds = "USD #{info["return"]["funds"]["usd"]}  BTC #{info["return"]["funds"]["btc"]}"
    end
  end

  def order(pair, type, rate, amount)
    trade = session_trade_object
    trade.Trade(pair: pair, type: type, rate: rate, amount: amount)
  end
  
  private
  def session_trade_object
    if session[:btce_trade].nil?
      #TODO Forward to login
    else
      session[:btce_trade]
    end
  end
end
