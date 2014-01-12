class TradeController < ApplicationController
  before_action :open_trade_connection, :account_info

  def open_orders
    @table = {}
    @table[:columns] = [
      { name: "pair", display_name: "Pair" },
      { name: "type", display_name: "Type" },
      { name: "amount", display_name: "Amount" },
      { name: "rate", display_name: "Rate" },
      { name: "timestamp_created", display_name: "Created" },
      { name: "status", display_name: "Status" },
      { name: "id", display_name: "id" }
    ]
    default_action(@trade.ActiveOrders, "timestamp_created")
  end

  def transaction_history
    @table = {}
    @table[:columns] = [
      { name: "type", display_name: "Type" },
      { name: "amount", display_name: "Amount" },
      { name: "currency", display_name: "Currency" },
      { name: "desc", display_name: "Description" },
      { name: "status", display_name: "Status" },
      { name: "timestamp", display_name: "Timestamp"},
      { name: "id", display_name: "id" }
    ]
    default_action(@trade.TransHistory, "timestamp")
  end

  def trade_history
    @table = {}
    @table[:columns] = [
      { name: "pair", display_name: "Pair" },
      { name: "type", display_name: "Type" },
      { name: "amount", display_name: "Amount" },
      { name: "rate", display_name: "Rate" },
      { name: "order_id", display_name: "OrderID" },
      { name: "is_your_order", display_name: "your order" },
      { name: "timestamp", display_name: "Timestamp"},
      { name: "id", display_name: "id" }
    ]
    default_action(@trade.TradeHistory, "timestamp")
  end

  protected
  def account_info
    if !(info = @trade.getInfo).nil? && info["success"] == 1
      @info = "USD #{info["return"]["funds"]["usd"]}  BTC #{info["return"]["funds"]["btc"]}"
    else
      flash[:error] = (!info.nil? && info["error"]) || "something failed"
    end
  end

  def default_action(result, timestamp)
    if !result.nil? && result["success"] == 1
      result = result["return"]
      result_collection = []
      result.each_pair{
        |pair| pair[1]["id"] = pair[0]
        if timestamp
          pair[1][timestamp] = Time.at(pair[1][timestamp])
        end
        result_collection<<pair[1]
      }
      @table[:collection] = result_collection
    else
      flash[:error] = (!result.nil? && result["error"]) || "something failed"
    end
    render :index
  end

  private
  def open_trade_connection
    @trade = Btce::Trade.new(@credentials[:apikey], @credentials[:secret])
  end
end
