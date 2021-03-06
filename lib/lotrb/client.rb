require "faraday"
require "faraday_middleware"

module Lotrb
  class Client
    BASE_URL = "https://the-one-api.dev/v2/"

    attr_reader :adapter

    def initialize(adapter: Faraday.default_adapter)
      @adapter = adapter
    end

    def self.instance(adapter: Faraday.default_adapter)
      @instance ||= new(adapter: adapter)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end

    def get(path, params = {})
      connection.get(path, params , auth_header)
    end

    private

    def auth_header
      { Authorization: "Bearer #{Lotrb.access_token}" }
    end
  end
end
