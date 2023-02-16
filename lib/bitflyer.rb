
# frozen_string_literal: true

require 'bitflyer/version'
require 'bitflyer/http'
require 'bitflyer/realtime'

module Bitflyer
  def realtime_client(key = nil, secret = nil)
    Bitflyer::Realtime::Client.new(key, secret)
  end

  def http_public_client