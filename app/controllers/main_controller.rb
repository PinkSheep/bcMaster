class MainController < ApplicationController
  before_action :authorize
  def index
    @btce_info = Btce::Info.new
    @btce_trade = {}
    @apikey = params[:apikey]
    @password = params[:password]
    if !@apikey.nil? && !@password.nil?
      trade = Btce::Trade.new(@apikey, @password)
      if !trade.nil?
        @btce_trade["getInfo"] = trade.getInfo
        if @btce_trade["success"] = 1
        	init_session(@apikey, @password)
        	redirect_to :controller => 'trade', :action => 'index'
        # else
        # 	# redirect_to :controller => 'main', :action => 'index'
    	end
        @btce_trade["ActiveOrders"] = trade.ActiveOrders
      end
    end
  end

  def login
    
  end

  private
  def init_session(key,secret)
  	key_array = [key,secret]
    session[:bcmaster] = key_array
  end

  protected
  def authorize
  	  @key_array = Array.new
  	  @key_array = session[:bcmaster]
  	if !@key_array[0].nil?	
  	  @login_message = "You are already logged in with the api-key " + @key_array[0] + " from "
  	else
  	  @login_message = "Please enter your API Key your Secret Key of "
  	  reset_session	
  	end
  end
end