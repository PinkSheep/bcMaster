class MainController < PublicController
  
  def index
    #holen der Kursinformationen von BTC-e
    btce_ticker = Btce::Info.new.ticker("btc_usd")
    @btce_buy
    @btce_sell
    if btce_ticker
      @btce_buy = btce_ticker["ticker"]["buy"]
      @btce_sell = btce_ticker["ticker"]["sell"]
    end
  end

  def login
    #Überprüfung der Verfügbarkeit des APIs
    if (apikey = params[:apikey]) && (password = params[:secret])
      trade = Btce::Trade.new(apikey, password).getInfo
      #Überprüfung der Zugangsdaten
      if trade && trade["success"] == 1
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

  private
  def init_session(key,secret)
    #zu implementieren: Verschlüsselung des secret keys, bevor der Key in die Session gespeichert wird
    session[:bcmaster] = {apikey: key, secret: secret}
  end
end
