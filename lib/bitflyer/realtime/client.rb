
# frozen_string_literal: true

require_relative './websocket'

module Bitflyer
  module Realtime
    PUBLIC_EVENT_NAMES = %w[lightning_board_snapshot lightning_board lightning_ticker lightning_executions].freeze
    MARKETS = %w[BTC_JPY XRP_JPY ETH_JPY XLM_JPY MONA_JPY ETH_BTC BCH_BTC FX_BTC_JPY BTCJPY_MAT1WK BTCJPY_MAT2WK