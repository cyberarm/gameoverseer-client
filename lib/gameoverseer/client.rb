require "renet"
require "multi_json"

require_relative "client/version"
require_relative "client/service_manager"
require_relative "client/service"

module GameOverseer
  class Client
    CHAT = 0 # channel int. used for in-game chat
    WORLD= 1 # channel int. used for sending/receiving world state updates
    HANDSHAKE = 2 # channel int. used for authentication or similar purposes
    FAULT=3 # channel int. used to send/receive errors
    attr_reader :socket

    def initialize(host = "localhost", port = 56789, compression = true)
      @host = host
      @port = port
      @compression = compression

      GameOverseer::Client.instance = self
      @service_manager = ServiceManager.new

      @socket = ENet::Connection.new(host, port, 4, 0, 0)
      @socket.use_compression(compression)
      @socket.on_packet_receive(method(:handle_packet))

      connect
    end

    def self.instance
      @instance
    end
    def self.instance=instance
      @instance = instance
    end

    def connect(timeout = 1000) # default to 1 second
      tries = 0
      begin
        @socket.connect(timeout)
      rescue StandardError
        tries+=1
        retry unless tries > 3
        raise if tries > 3
      end
    end

    def online?
      @socket.online?
    end

    def connected?
      @socket.connected?
    end

    def handle_packet(data, channel)
      _data= data.chomp.strip
      data = MultiJson.load(_data)
      ServiceManager.instance.handle_packet(data, channel)
    end

    def disconnect(timeout = 1000)
      tries = 0
      begin
        @socket.disconnect(timeout)
      rescue StandardError
        tries+=1
        retry unless tries > 3
        raise if tries > 3
      end
    end

    def transmit(channel, mode, data = nil, channel_id = CHAT, reliable = false)
      raise "channel must be a String" unless channel.is_a?(String)
      raise "mode must be a String"    unless mode.is_a?(String)
      raise "data must be a Hash"      unless data.is_a?(Hash) or data == nil
      raise "reliable must be a Boolean" unless reliable.is_a?(TrueClass) or reliable.is_a?(FalseClass)

      if data
        message = MultiJson.dump({channel: channel, mode: mode, data: data})
      else
        message = MultiJson.dump({channel: channel, mode: mode})
      end
      @socket.send_packet(message, reliable, channel_id)
    end

    def update(timeout = 0)
      @socket.update(timeout)
    end
  end
end
