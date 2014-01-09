class MainController < ApplicationController
  before_action :authorize

  def index
    #holen der Kursinformationen von BTC-e
    btce_ticker = Btce::Info.new.ticker("btc_usd")
    @btce_buy
    @btce_sell
    unless btce_ticker.nil?
      @btce_buy = btce_ticker["ticker"]["buy"]
      @btce_sell = btce_ticker["ticker"]["sell"]
    end
  end

  def login
    #Überprüfung der Verfügbarkeit des APIs
    if !(apikey = params[:apikey]).nil? && !(password = params[:password]).nil?
      trade = Btce::Trade.new(apikey, password).getInfo
      #Überprüfung der Zugangsdaten
      if !trade.nil? && trade["success"] == 1
        init_session(apikey, password)
        return redirect_to :controller => 'trade', :action => 'index'
      else
        flash.now[:alert] = "Login failed.\n #{trade}"
      end
    end
    redirect_to :controller => 'main', :action => 'index'
  end
  
  def logout
    reset_session
    redirect_to :controller => "main", :action => "index"
  end

  private
  def init_session(key,secret)
    #zu implementieren: Verschlüsselung des secret keys, bevor der Key in die Session gespeichert wird
    key_array = [key,secret]
    session[:bcmaster] = key_array
  end

  protected
  def authorize
    @key_array = Array.new
    @key_array = session[:bcmaster]
    if !@key_array.nil?
      @login_message = "You are already logged in with the api-key " + @key_array[0] + " from "
      @login_form = false
    else
      @login_message = "Please enter your API Key and your Secret Key of "
      @login_form = true
    end
  end
end
