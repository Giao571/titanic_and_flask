
# bitflyer
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-4-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
[![Gem Version](https://badge.fury.io/rb/bitflyer.svg)](https://badge.fury.io/rb/bitflyer)
[![Circle CI](https://circleci.com/gh/unhappychoice/bitflyer.svg?style=shield)](https://circleci.com/gh/unhappychoice/bitflyer)
[![Code Climate](https://codeclimate.com/github/unhappychoice/bitflyer/badges/gpa.svg)](https://codeclimate.com/github/unhappychoice/bitflyer)
[![Libraries.io dependency status for GitHub repo](https://img.shields.io/librariesio/github/unhappychoice/bitflyer.svg)](https://libraries.io/github/unhappychoice/bitflyer)
![](http://ruby-gem-downloads-badge.herokuapp.com/bitflyer?type=total)
![GitHub](https://img.shields.io/github/license/unhappychoice/bitflyer.svg)

bitflyer is a wrapper interface of [Bitflyer lightning API](https://lightning.bitflyer.jp/docs)  

## Installation

```sh
gem install bitflyer
```

## Usage

See https://lightning.bitflyer.jp/docs for details.

### HTTP API

See [public.rb](./lib/bitflyer/http/public.rb) / [private.rb](./lib/bitflyer/http/private.rb) for method definition.

#### Example

```ruby 
public_client = Bitflyer.http_public_client
p public_client.board # will print board snapshot
 
private_client = Bitflyer.http_private_client('YOUR_API_KEY', 'YOUR_API_SECRET')
p private_client.positions # will print your positions
```

### Realtime API

#### Public events

Accessor format is like `{event_name}_{product_code}`.
You can set lambda to get realtime events.

`{event_name}` and `{product_code}` is defined at [client.rb](./lib/bitflyer/realtime/client.rb).

#### Private events

To subscribe to the private `child_order_events` and `parent_order_events`, pass your API key and secret when creating the `realtime_client`.

#### Connection status monitoring

The `ready` callback is called when the `realtime_client` is ready to receive events (after the socket connection is established, the optional authentication has succeeded, and the channels have been subscribed). If connection is lost, the `disconnected` callback is called, and reconnection is attempted automatically. When connection is restored, `ready` is called again.

#### Examples

For public events only:
```ruby
client = Bitflyer.realtime_client
client.ticker_btc_jpy = ->(json){ p json } # will print json object
client.executions_btc_jpy = ->(json){ p json }
# ...
```

For both public and private events:
```ruby
client = Bitflyer.realtime_client('YOUR_API_KEY', 'YOUR_API_SECRET')
# Private events:
client.child_order_events = ->(json){ p json }
client.parent_order_events = ->(json){ p json }
# Public events: