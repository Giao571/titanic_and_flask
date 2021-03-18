# frozen_string_literal: true

module Bitflyer
  module HTTP
    module Private
      class Client # rubocop:disable Metrics/ClassLength
        def initialize(key, secret)
          @connection = Connection.