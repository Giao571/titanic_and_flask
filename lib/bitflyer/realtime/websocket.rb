
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
        @host = host
        @key = key
        @secret = secret
        @debug = debug
        @channel_names = []
        @channel_callbacks = {}
        connect
        start_monitoring
      end

      def subscribe(channel_name:, &block)
        debug_log "Subscribe #{channel_name}"
        @channel_names = (@channel_names + [channel_name]).uniq
        @channel_callbacks[channel_name] = block
        @websocket_client.send "42#{['subscribe', channel_name].to_json}"
      end

      def connect
        @websocket_client = WebSocket::Client::Simple.connect "#{@host}/socket.io/?transport=websocket"
        this = self
        @websocket_client.on(:message) { |payload| this.handle_message(payload: payload) }
        @websocket_client.on(:error) { |error| this.handle_error(error: error) }
        @websocket_client.on(:close) { |error| this.handle_close(error: error) }
      rescue SocketError => e
        puts e
        puts e.backtrace.join("\n")
      end

      def start_monitoring
        Thread.new do
          loop do
            sleep 1
            if @websocket_client&.open?
              send_ping
              wait_pong
            else
              reconnect
            end
          end
        end
      end

      def send_ping
        return unless @last_ping_at && @ping_interval
        return unless Time.now.to_i - @last_ping_at > @ping_interval / 1000

        debug_log 'Sent ping'
        @websocket_client.send '2'
        @last_ping_at = Time.now.to_i
      end

      def wait_pong
        return unless @last_pong_at && @ping_timeout