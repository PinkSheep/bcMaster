class LoginController < ApplicationController

  layout "main"

  def login
    @apikey = params[:apikey]
    @password = params[:password]
  end
end
