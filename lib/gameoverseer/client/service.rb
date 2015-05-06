module GameOverseer
  class Client
    class Service
      def self.inherited(klass)
        ServiceManager::SERVICES.push(klass)
      end

      def initialize
        setup if defined?(setup)
      end

      def register_channel(string)
        if ServiceManager.instance.register_channel(self, string)
          true
        else
          false
        end
      end

      def transmit(channel, mode, data, channel_id = GameOverseer::Client::CHAT, reliable = false)
        raise "data must be a Hash when sent from a Service" unless data.is_a?(Hash)
        Client.instance.transmit(channel, mode, data, channel_id, reliable)
      end
    end
  end
end
