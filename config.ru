require 'bundler/setup'
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")

require "synchrony"
map("/monitor") { run Synchrony::Apps::Monitor }
map("/api")     { run Synchrony::Apps::Api }


map("/faye") do
  require 'faye'
  Faye::WebSocket.load_adapter('thin')
  run Faye::RackAdapter.new({:mount => '/', :timeout => 25 })
end

run Synchrony::Apps::Base
