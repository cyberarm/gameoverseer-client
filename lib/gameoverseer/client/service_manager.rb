module GameOverseer
  class Client
    class ServiceManager
      SERVICES = []
      CHANNELS = []

      def initialize
        GameOverseer::Client::ServiceManager.instance = self
        SERVICES.each do |s|
          s.new
        end
      end

      def self.instance
        @instance
      end

      def self.instance=instance
        @instance = instance
      end

      def register_channel(instance, string)
        service = CHANNELS.detect do |_service|
          if _service[:channel] == string
            true
          end
        end

        raise "channel '#{string}' in use by '#{service[:instance]}'" if service

        CHANNELS.push({instance: instance, channel: string})
        return true
      end

      def handle_packet(data, channel)
        service_channel = data["channel"]
        # service_method  = data["mode"]

        CHANNELS.each do |service|
          if service[:channel] == service_channel
            service[:instance].process_data(data, channel)
          end
        end
      end
    end
  end
end
