# frozen_string_literal: true

module Bitflyer
  module HTTP
    module Private
      class Client # rubocop:disable Metrics/ClassLength
        def initialize(key, secret)
          @connection = Connection.new(key, secret)
        end

        def permissions
          @connection.get('/v1/me/getpermissions').body
        end

        def balance
          @connection.get('/v1/me/getbalance').body
        end

        def collateral
