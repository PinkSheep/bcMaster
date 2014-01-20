class TradeController < PrivateController

  def open_orders
    @title = "Open Orders"
    default_action(@trade.ActiveOrders)
  end

  def transaction_history
    @title = "Transaction History"
    default_action(@trade.TransHistory)
  end

  def trade_history
    @title = "Trade History"
    default_action(@trade.TradeHistory)
  end
  
  def create_order
    flash_no_trade_permission && return
    if params[:commit]
      if (result = @trade.Trade(order_params))["success"] == 1
        flash.now[:notice] = result
        return redirect_to open_orders_url
      else
        flash.now[:error] = result && result["error"] || "all fields are required"
      end
    end
  end

  protected
  def default_action(result)
    @table = {}
    if result && result["success"] == 1
      @table[:collection] = result["return"].map{ |key, value|
        value["id"] = key
        # Convert Unix time to UTC
        value.each{ |a,b| value[a] = Time.at(b).gmtime if a.include? "timestamp" }
      }
      @table[:columns] = @table[:collection][0].map{ |key, value|
        {name: key, display_name: Btce::API::PARAMETER_DISPLAY_NAME[key]}
      }
    else
      flash.now[:error] = (result && result["error"]) || "something failed"
    end
    render :index
  end
  
  private
  def order_params
    params.permit(:pair, :type, :rate, :amount)
  end
  def flash_no_trade_permission
    flash.now[:error] = "api-key does not have trade permission" if @rights && @rights["trade"] != 1
  end
end
