class MainController < PublicController
  before_action :contents
  
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
    if !(apikey = params[:apikey]).nil? && !(password = params[:secret]).nil?
      trade = Btce::Trade.new(apikey, password).getInfo
      #Überprüfung der Zugangsdaten
      if !trade.nil? && trade["success"] == 1
        init_session(apikey, password)
        return redirect_to trade_index_url
      end
    end
    flash[:error] = (trade && trade["error"]) || "apikey or password missing"
    redirect_to main_index_url
  end
  
  def logout
    reset_session
    flash[:notice] = "logged out"
    redirect_to main_index_url
  end
  
  protected
  def contents
    if !@key_array.nil?
      @login_message = "You are already logged in with the api-key " + @key_array[0] + " from "
      @login_form = false
    else
      @login_message = "Please enter your API Key and your Secret Key of "
      @login_form = true
    end
  end

  private
  def init_session(key,secret)
    #zu implementieren: Verschlüsselung des secret keys, bevor der Key in die Session gespeichert wird
    session[:bcmaster] = {apikey: key, secret: secret}
  end
end
