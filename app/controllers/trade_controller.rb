class TradeController < ApplicationController

  def open_orders
    @title = "Open Orders"
    default_action(
      @trade.ActiveOrders,
      [ { name: "pair", display_name: "Pair" },
        { name: "type", display_name: "Type" },
        { name: "amount", display_name: "Amount" },
        { name: "rate", display_name: "Rate" },
        { name: "timestamp_created", display_name: "Created" },
        { name: "status", display_name: "Status" },
        { name: "id", display_name: "id" } ],
      "timestamp_created" )
  end

  def transaction_history
    @title = "Transaction History"
    default_action(
      @trade.TransHistory,
      [ { name: "type", display_name: "Type" },
        { name: "amount", display_name: "Amount" },
        { name: "currency", display_name: "Currency" },
        { name: "desc", display_name: "Description" },
        { name: "status", display_name: "Status" },
        { name: "timestamp", display_name: "Timestamp"},
        { name: "id", display_name: "id" } ],
      "timestamp" )
  end

  def trade_history
    @title = "Trade History"
    default_action(
      @trade.TradeHistory,
      [ { name: "pair", display_name: "Pair" },
        { name: "type", display_name: "Type" },
        { name: "amount", display_name: "Amount" },
        { name: "rate", display_name: "Rate" },
        { name: "order_id", display_name: "OrderID" },
        { name: "is_your_order", display_name: "your order" },
        { name: "timestamp", display_name: "Timestamp"},
        { name: "id", display_name: "id" } ],
      "timestamp" )
  end
  
  def create_order
    return flash[:error] = "api-key does not have trade permission" if @rights && @rights["trade"] != 1
    if (pair=params[:pair]) && (type=params[:type]) && (rate=params[:rate]) && (amount=params[:amount])
      if (result = @trade.Trade(pair: pair, type: type, rate: rate, amount: amount))["success"] == 1
        flash[:notice] = result
        return redirect_to open_orders_url
      end
    end
    if params[:commit]
      flash[:error] = result && result["error"] || "all fields are required"
    end
  end

  protected
  def default_action(result, columns, timestamp)
    @table = {}
    @table[:columns] = columns
    if result && result["success"] == 1
      @table[:collection] = result["return"].collect{
        |p| p[1]["id"] = p[0]
        if timestamp
          p[1][timestamp] = Time.at(p[1][timestamp])
        end
        p[1]
      }
    else
      flash[:error] = (result && result["error"]) || "something failed"
    end
    render :index
  end
end
