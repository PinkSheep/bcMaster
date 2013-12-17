class LoginController < ApplicationController

  layout "main"

  def login
    @apikey = params[:apikey]
    @password = params[:password]
    @btce_trade = Btce::Trade.new({
      key: params[:apikey],
      secret: params[:password],
      url: params[:domain] })
  end
end
