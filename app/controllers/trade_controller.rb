class TradeController < ApplicationController
  before_action :open_trade_connection

  def index
    if !(info = @trade.getInfo).nil? && info["success"] == 1
      @info = "USD #{info["return"]["funds"]["usd"]}  BTC #{info["return"]["funds"]["btc"]}"
    else
      flash[:error] = (!info.nil? && info["error"]) || "something failed"
    end
    @orders = {}
    @orders[:columns] = [
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
      @orders[:collection] = order_collection
    else
      flash[:error] = (!orders.nil? && orders["error"]) || "something failed"
    end
  end

  private
  def open_trade_connection
    @trade = Btce::Trade.new(@credentials[:apikey], @credentials[:secret])
  end
end
