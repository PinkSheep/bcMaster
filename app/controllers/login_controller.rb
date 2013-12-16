require 'Btce'

class LoginController < ApplicationController

  layout "main"

  def login
    @apikey = params[:apikey]
    @password = params[:password]
    api = {
      key: params[:apikey],
      secret: params[:password],
      url: params[:domain] }
    @btce_trade = Btce::Trade.new(api)
  end
end
