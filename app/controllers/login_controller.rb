class LoginController < ApplicationController

  layout "main"

  def login
    @btce_trade = {}
    @apikey = params[:apikey]
    @password = params[:password]
    if !params[:apikey].nil? && !params[:password].nil?
      trade = Btce::Trade.new(params[:apikey], params[:password])
      if !trade.nil?
        init_session(params[:apikey])
        @btce_trade["getInfo"] = trade.getInfo
        @btce_trade["ActiveOrders"] = trade.ActiveOrders
      end
    end
  end

  private
  def init_session(key)
    @sessiondata = key
    session[:bcmaster] = @sessiondata
  end
end
