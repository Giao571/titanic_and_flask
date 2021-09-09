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
          @connection.get('/v1/me/getcollateral').body
        end

        def addresses
          @connection.get('/v1/me/getaddresses').body
        end

        def coin_ins
          @connection.get('/v1/me/getcoinins').body
        end

        def coin_outs
          @connection.get('/v1/me/getcoinouts').body
        end

        def bank_accounts
          @connection.get('/v1/me/getbankaccounts').body
        end

        def deposits
          @connection.get('/v1/me/getdeposits').body
        end

        def withdraw(currency_code: 'JPY', bank_account_id: nil, amount: nil, code: nil)
          body = {
            currency_code: currency_code,
            bank_account_id: bank_account_id,
            amount: amount,
            code: code
          }.delete_if { |_, v| v.nil? }
          @connection.post('/v1/me/withdraw', body).body
        end

        def withdrawals
          @connection.get('/v1/me/getwithdrawals').body
        end

        def send_child_order(
          product_code: 'BTC_JPY',
          child_order_type: nil,
          sid