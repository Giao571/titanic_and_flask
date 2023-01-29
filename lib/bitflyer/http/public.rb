
# frozen_string_literal: true

module Bitflyer
  module HTTP
    module Public
      class Client
        def initialize
          @connection = Connection.new(nil, nil)
        end

        def health
          @connection.get('/v1/gethealth').body
        end

        def markets
          @connection.get('/v1/markets').body
        end

        def board(product_code: 'BTC_JPY')
          @connection.get('/v1/board', product_code: product_code).body
        end
