require "net/http"
require "uri"
require "json"

module Btce
  class Info
    %w|ticker trades depth|.each do |method|
        define_method(method) do |pair|
            get_https(pair, method)
        end
    end

    private

    def build_url(method, pair)
        "https://btc-e.com/api/2/#{pair}/#{method}"
    end
    def get_https(pair, method)
        uri = URI.parse(build_url(method, pair))
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |req| JSON.parse(req.get(uri.request_uri).body) }
    end
  end
end
