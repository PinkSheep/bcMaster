require "net/http"
require "uri"
require "json"
require "yaml"

module Btce

  class Drive
    def initialize(settings)
      @key = settings[:key]
      @secret = settings[:secret]
      @uri = URI.parse(settings[:url])
      @nonce = Time.now.to_i
    end

    def connect(data)
      @nonce += 1
      data[:nonce] = @nonce
      send_data = data.map{ |x,v| "#{x}=#{v}" }.reduce{|x,v| "#{x}&#{v}" }
      headers = {}
      headers['Key'] = @key
      headers['Sign'] = hmac(send_data)
      JSON.parse post_https(@uri.host, @uri.port, "/tapi", send_data, headers)
    end

    private
    def hmac(data)
      sha = OpenSSL::Digest.new('sha512')
      OpenSSL::HMAC.hexdigest(sha, @secret, data)
    end

    def post_https(uri, port, url, send_data, headers)
      Net::HTTP.start(uri, port, use_ssl: true) do |request|
          request.post(url, send_data, headers).body
        end
    end
  end

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
