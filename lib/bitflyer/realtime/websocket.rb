
# frozen_string_literal: true

require 'websocket-client-simple'
require 'json'
require 'openssl'

module Bitflyer
  module Realtime
    class WebSocketClient
      attr_accessor :websocket_client, :channel_names, :channel_callbacks, :ping_interval, :ping_timeout,
                    :last_ping_at, :last_pong_at, :ready, :disconnected

      def initialize(host:, key:, secret:, debug: false)