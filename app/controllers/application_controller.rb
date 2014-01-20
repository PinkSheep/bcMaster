class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize, :init_ticker

  protected
  def authorize
  	#falls keine Session vorhanden ist, wird man wieder auf die Mainseite weitergeleitet
    if @credentials = session[:bcmaster]
      @trade = Btce::Trade.new(@credentials[:apikey], @credentials[:secret])
      if (info = @trade.getInfo) && info["success"] == 1
        @rights = info["return"]["rights"]
        @info = info["return"]["funds"].select{
          |currency, amount| amount != 0 || currency == "usd" || currency == "btc"
        }.map{|currency, amount| currency + ": " + amount.to_s }.reduce{|a,b| a+" "+b}
      else
        flash.now[:error] = (info && info["error"]) || "something failed"
      end
    else
      if is_a?(PrivateController)
        flash.now[:notice] = "sign in first"
        return redirect_to root_url
      end
    end
  end
  def init_ticker
    #holen der Kursinformationen von BTC-e
    btce_ticker = Btce::Info.new.ticker("btc_usd")
    @btce_buy
    @btce_sell
    if btce_ticker
      @btce_buy = btce_ticker["ticker"]["buy"]
      @btce_sell = btce_ticker["ticker"]["sell"]
    end
  end
end
