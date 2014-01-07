class LoginController < ApplicationController

  layout "main"

  def login
    @btce_trade = {}
    @apikey = params[:apikey]
    @password = params[:password]
    if !@apikey.nil? && !@password.nil?
      trade = Btce::Trade.new(@apikey, @password)
      if !trade.nil?
        init_session(trade)
        @btce_trade["getInfo"] = trade.getInfo
        @btce_trade["ActiveOrders"] = trade.ActiveOrders
      end
    end
  end

  private
  def init_session(trade)
    session[:btce_trade] = trade
  end
end
