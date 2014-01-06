require "net/http"
require "uri"
require "json"

module Btce
  class Info < API
    # Provides access to open API.
    # https://hdbtce.kayako.com/Knowledgebase/Article/View/28/4/public-api
    %w(ticker trades depth fee).each do |method|
      define_method(method) do |pair|
        get_https(pair, method)
      end
    end

    private

    def build_url(method, pair)
        "https://#{API::DOMAIN}/api/2/#{pair}/#{method}"
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