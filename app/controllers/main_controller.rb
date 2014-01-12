class MainController < PublicController
  def login
    #Überprüfung der Verfügbarkeit des APIs
    if (apikey = params[:apikey]) && (secret = params[:secret])
      trade = Btce::Trade.new(apikey, secret).getInfo
      #Überprüfung der Zugangsdaten
      if trade && trade["success"] == 1
        init_session(apikey, secret)
        return redirect_to trade_open_orders_url
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
