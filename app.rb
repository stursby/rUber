require 'sinatra'
require 'httparty'

class Uber
    include HTTParty
    base_uri 'https://api.uber.com/v1'

    def initialize(server_token, latitude, longitude)
        @options = { query: {
            server_token: server_token,
            latitude: latitude,
            longitude: longitude
        }}
    end

    # https://developer.uber.com/v1/endpoints/#product-types
    def products
        self.class.get('/products', @options)
    end
end

# Lat / Lng demo for Minneapolis
uber = Uber.new(ENV['SERVER_TOKEN'], 37.775818, -122.418028)

get '/' do
    content_type 'html'
    erb :index, :locals => {:data => uber.products}
end