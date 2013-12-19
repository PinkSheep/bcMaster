module Btce
  class Trade < API
    def initialize(key, secret)
        @drive = Drive.new("https://#{API::DOMAIN}", key, secret)
    end
    %w| getInfo
        TransHistory
        TradeHistory
        ActiveOrders
        Trade
        CancelOrder |.each do |method|
      define_method(method) do |options = {}|
        @drive.connect(method, options)
      end
    end
  end
end