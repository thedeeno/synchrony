module Synchrony
  def self.root
    File.expand_path("..", __dir__)
  end

  def self.pubsub_address
    "localhost:#{pubsub_port}"
  end

  def self.pubsub_port
    ENV["SYNCHRONY_PUBSUB_PORT"] ||= 5566
  end

  def self.publisher
    @publisher 
  end

  def self.publisher=(v)
    @publisher = v
  end

  require_relative "synchrony/errors"
  require_relative "synchrony/models"
  require_relative "synchrony/services"
  require_relative "synchrony/apps"
end

