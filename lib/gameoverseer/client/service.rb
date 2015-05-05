module GameOverseer
  class Client
    class Service
      def self.inherited(klass)
        ServiceManager::SERVICES.push(klass)
      end

      def register_channel(string)
        if ServiceManager.instance.register_channel(self, string)
          true
        else
          false
        end
      end

      def send(channel, mode, data, channel_id = GameOverseer::Client::CHAT, reliable = false)
        Client.instance.send(channel, mode, data, channel_id, reliable)
      end
    end
  end
end
