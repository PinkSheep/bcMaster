class MainController < ApplicationController
  before_action :authorize
  def index
    btce_ticker = Btce::Info.new.ticker("btc_usd")
    @btce_buy
    @btce_sell
    unless btce_ticker.nil?
      @btce_buy = btce_ticker["ticker"]["buy"]
      @btce_sell = btce_ticker["ticker"]["sell"]
    end
  end

  protected
  def authorize
  end
end
