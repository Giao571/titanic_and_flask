
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