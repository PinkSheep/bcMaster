module Bitstamp
  class API
    # https://www.bitstamp.net/api/
    DOMAIN = "www.bitstamp.net"
    def api_methods
      self.class.instance_methods(false)
    end
  end
end
