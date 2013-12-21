require "net/http"
require "uri"
require "json"

module Btce
  class Drive
    def initialize(url, key, secret)
      @key = key
      @secret = secret
      @uri = URI.parse(url)
      @nonce = Time.now.to_i
    end
    def connect(method, data)
      data[:nonce] = (@nonce += 1)
      data[:method] = method
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
      begin
        Net::HTTP.start(uri, port, use_ssl: true) {
          |req| req.post(url, send_data, headers).body }
      rescue
        nil
      end
    end
  end
end