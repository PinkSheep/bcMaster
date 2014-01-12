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

  protected
  def default_action(result, columns, timestamp)
    @table = {}
    @table[:columns] = columns
    if result && result["success"] == 1
      result_collection = []
      result["return"].each_pair{
        |pair| pair[1]["id"] = pair[0]
        if timestamp
          pair[1][timestamp] = Time.at(pair[1][timestamp])
        end
        result_collection << pair[1]
      }
      @table[:collection] = result_collection
    else
      flash[:error] = (result && result["error"]) || "something failed"
    end
    render :index
  end
end
