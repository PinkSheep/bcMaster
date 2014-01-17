class TradeController < ApplicationController

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
    return flash[:error] = "api-key does not have trade permission" if @rights && @rights["trade"] != 1
    if (pair=params[:pair]) && (type=params[:type]) && (rate=params[:rate]) && (amount=params[:amount])
      if (result = @trade.Trade(pair: pair, type: type, rate: rate, amount: amount))["success"] == 1
        flash.now[:notice] = result
        return redirect_to open_orders_url
      end
    end
    if params[:commit]
      flash.now[:error] = result && result["error"] || "all fields are required"
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
end
