module Btce
  class Trade < TradeAPI
    # https://btc-e.com/api/documentation
    def initialize(key, secret)
        @drive = Drive.new("https://#{API::DOMAIN}", key, secret)
    end

    # Overwrite API methods
    Btce::TradeAPI.public_instance_methods(false).each do |method|
      define_method(method.to_s) do |options = {}|
        @drive.connect(method, options)
      end
    end
  end
end