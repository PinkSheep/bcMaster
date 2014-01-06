require "net/http"
require "uri"
require "json"

module Bitstamp
  class Public < API
    %w(ticker order_book transactions eur_usd).each do |method| 
      define_method(method.to_s) do |options={}|
        data = options.map{ |x,v| "#{x}=#{v}" }.reduce{|x,v| "#{x}&#{v}" }
        get_https(data, method)
      end
    end

    private

    def build_url(method, pair)
        "https://#{API::DOMAIN}/api/#{method}/"
    end
    def get_https(pair, method)
      uri = URI.parse(build_url(method, pair))
      begin
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) {
          |req| JSON.parse(req.get(uri.request_uri).body) }
      rescue
        nil
      end
    end
  end
end
