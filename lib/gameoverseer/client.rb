require "renet"
require "multi_json"

module GameOverseer
  class Client
    CHAT = 0 # channel int. used for in-game chat
    WORLD= 1 # channel int. used for sending/receiving world state updates
    HANDSHAKE = 2 # channel int. used for authentication or similar purposes
    FAULT=3 # channel int. used to send/receive errors

    def initialize(host = "localhost", port = 56789, compression = true)
      @host = host
      @port = port
      @compression = compression

      @socket = ENet::Connection.new(host, port, 4, 0, 0)
      @socket.use_compression(compression)
      connect
    end

    def connect(timeout = 1000) # default to 1 second
      # TODO: gracefully attempt to connect to Server.
    end

    def disconnect(timeout = 1000)
      # TODO: Gracefully attempt to connect to Server.
    end

    def send(channel, mode, hash, channel_id = WORLD, reliable = false)
      # channel is a String
      # mode is a ?
      # hash is a Hash
      # reliable is a Boolean

      message = MultiJson.dump({channel: channel, mode: mode, data: hash})
      @socket.send_packet(message, reliable, channel_id)
    end

    def handle_connect(method)
      @socket.on_connection(method)
    end

    def handle_packet(method)
      @socket.on_packet_receive(method)
    end

    def handle_disconnect(method)
      @socket.on_disconnection(method)
    end

    def update(timeout = nil)
      if timeout && timeout.is_a?(Integer)
        @socket.update(timeout)
      else
        @socket.update
      end
    end
  end
end
