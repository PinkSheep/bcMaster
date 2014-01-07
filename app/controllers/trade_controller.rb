class TradeController < ApplicationController
  def index
    trade = session[:bcmaster]
    @info = trade.getInfo
  end
end
