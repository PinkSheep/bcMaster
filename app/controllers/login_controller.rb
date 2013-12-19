class LoginController < ApplicationController

  layout "main"

  def login
    @apikey = params[:apikey]
    @password = params[:password]
    @btce_trade = Btce::Trade.new(params[:apikey], params[:password])
  end
end
