[![Code Climate](https://codeclimate.com/github/cyberarm/gameoverseer-client/badges/gpa.svg)](https://codeclimate.com/github/cyberarm/gameoverseer-client)
[![Inline docs](http://inch-ci.org/github/cyberarm/gameoverseer-client.svg?branch=master)](http://inch-ci.org/github/cyberarm/gameoverseer-client)

# GameOverseer::Client

Client library for GameOverseer.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gameoverseer-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gameoverseer-client

## Usage

Simple example
```ruby
require "gameoverseer/client"

client = GameOverseer::Client.new("localhost", 56789)
client.transmit({channel: 'world', mode: 'connect', data: {access_token: "f2a..."}})
client.disconnect
```

## Contributing

1. Fork it ( https://github.com/cyberarm/gameoverseer-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
