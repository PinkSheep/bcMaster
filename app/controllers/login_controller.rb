class LoginController < ApplicationController

  layout "main"

  def login
    @btce_trade = {}
    @apikey = params[:apikey]
    @password = params[:password]
    if !@apikey.nil? && !@password.nil?
      trade = Btce::Trade.new(@apikey, @password)
      if !trade.nil?
        @btce_trade["getInfo"] = trade.getInfo
        @btce_trade["ActiveOrders"] = trade.ActiveOrders
      end
    end
  end
end
