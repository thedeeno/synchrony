module Synchrony
  # Wraps a faye client
  class Publisher
    def initialize(uri)
      @uri = uri
    end

    def client
      @client ||= Faye::Client.new(@uri)
    end

    def publish(channel, message)
      client.publish(channel, message)
    end
  end
end
