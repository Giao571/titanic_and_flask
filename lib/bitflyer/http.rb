
# frozen_string_literal: true

require 'bitflyer'
require 'bitflyer/http/public'
require 'bitflyer/http/private'
require 'faraday'
require 'faraday_middleware'
require 'openssl'

module Bitflyer
  module HTTP
    class Connection
      extend Forwardable

      def_delegators :@connection, :get, :post

      def initialize(key, secret)
        @connection = Faraday::Connection.new(url: 'https://api.bitflyer.jp') do |f|
          f.request :json
          f.response :json
          f.use Authentication, key, secret
          f.adapter Faraday.default_adapter
        end
      end
    end

    class Authentication < Faraday::Middleware
      def initialize(app, key, secret)
        super(app)
        @key = key
        @secret = secret
      end

      def call(env)
        return @app.call(env) if @key.nil? || @secret.nil?

        timestamp = Time.now.to_i.to_s