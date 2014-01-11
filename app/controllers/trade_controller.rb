class TradeController < ApplicationController
  before_action :open_trade_connection

  def index
    if !(info = @trade.getInfo).nil? && info["success"] == 1
      @info = info["return"]
    else
      flash[:error] = (!info.nil? && info["error"]) || "something failed"
    end
    if !(orders = @trade.ActiveOrders).nil? && orders["success"] == 1
      @orders = orders["return"]
    else
      flash[:error] = (!orders.nil? && orders["error"]) || "something failed"
    end
  end

  protected
  # http://stackoverflow.com/questions/3863844/rails-how-to-build-table-in-helper-using-content-tag
  def display_standard_table(columns, collection = {})
    thead = content_tag :thead do
      content_tag :tr do
        columns.collect {|column|  concat content_tag(:th,column[:display_name])}.join().html_safe
      end
    end
    tbody = content_tag :tbody do
      collection.collect { |elem|
        content_tag :tr do
          columns.collect { |column|
            concat content_tag(:td, elem.attributes[column[:name]])
          }.to_s.html_safe
        end
      }.join().html_safe
    end
    content_tag :table, thead.concat(tbody)
  end

  private
  def open_trade_connection
    @trade = Btce::Trade.new(@credentials[:apikey], @credentials[:secret])
  end
end
