module Btce
  class Trade
    def initialize(settings)
        @drive = Drive.new(settings)
    end
    @@methods = %w|getInfo TransHistory TradeHistory ActiveOrders Trade CancelOrder|

    @@methods.each do |method|
      define_method(method) do |options = {}|
        options[:method] = method
        @drive.connect(options)
      end
    end
  end
end
