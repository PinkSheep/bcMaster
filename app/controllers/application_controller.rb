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
        @info = "USD #{info["return"]["funds"]["usd"]}  BTC #{info["return"]["funds"]["btc"]}"
      else
        flash[:error] = (info && info["error"]) || "something failed"
      end
    end
    if !self.is_a?(PublicController) && !@credentials
      flash[:notice] = "sign in first"
      redirect_to root_url
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
