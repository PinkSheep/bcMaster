class TradeController < ApplicationController
  before_action :open_trade_connection

  def index
    account_info
  end

  def open_orders
    account_info
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
    if !(orders = @trade.ActiveOrders).nil? && orders["success"] == 1
      orders = orders["return"]
      order_collection = []
      orders.each_pair{
        |pair| pair[1]["id"] = pair[0]
        pair[1]["timestamp_created"] = Time.at(pair[1]["timestamp_created"])
        order_collection<<pair[1]
      }
      @table[:collection] = order_collection
    else
      flash[:error] = (!orders.nil? && orders["error"]) || "something failed"
    end
    render :index
  end

  def transaction_history
    account_info
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
    if !(transactions = @trade.TransHistory).nil? && transactions["success"] == 1
      transactions = transactions["return"]
      trans_collection = []
      transactions.each_pair{
        |pair| pair[1]["id"] = pair[0]
        pair[1]["timestamp"] = Time.at(pair[1]["timestamp"])
        trans_collection<<pair[1]
      }
      @table[:collection] = trans_collection
    else
      flash[:error] = (!transactions.nil? && transactions["error"]) || "something failed"
    end
    render :index
  end

  def trade_history
    account_info
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
    if !(trades = @trade.TradeHistory).nil? && trades["success"] == 1
      trades = trades["return"]
      trades_collection = []
      trades.each_pair{
        |pair| pair[1]["id"] = pair[0]
        pair[1]["timestamp"] = Time.at(pair[1]["timestamp"])
        trades_collection<<pair[1]
      }
      @table[:collection] = trades_collection
    else
      flash[:error] = (!trades.nil? && trades["error"]) || "something failed"
    end
    render :index
  end

  protected
  def account_info
    if !(info = @trade.getInfo).nil? && info["success"] == 1
      @info = "USD #{info["return"]["funds"]["usd"]}  BTC #{info["return"]["funds"]["btc"]}"
    else
      flash[:error] = (!info.nil? && info["error"]) || "something failed"
    end
  end

  private
  def open_trade_connection
    @trade = Btce::Trade.new(@credentials[:apikey], @credentials[:secret])
  end
end
