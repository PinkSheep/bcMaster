require 'Btce'

class LoginController < ApplicationController

  layout "main"

  def login
    @apikey = params[:apikey]
    @password = params[:password]
    api = YAML.load_file("./api_keys.yml")
    @btce_api = api
    @btce_info = Btce::Info.new
    @btce_trade = Btce::Trade.new(api)
  end
end