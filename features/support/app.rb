module Synchrony
module Acceptance
  class App
    attr_accessor :host, :port
    def initialize
      @host = ENV["SYNCHRONY_WEB_HOST"]
      @port = ENV["SYNCHRONY_WEB_PORT"]
    end

    def available?
      return false if host.nil? or port.nil?

      http = Net::HTTP.start(host, port, {open_timeout: 5, read_timeout: 5})
      response = http.head("/")
      response.code == "200" || response.code == "302"
    rescue Timeout::Error, SocketError
      false
    end

    def inspect
      "{App: #{host}:#{port}}"
    end

    def home
      "http://#{host}:#{port}/"
    end

    def post(route, options={})
      uri = URI("http://#{ENV["SYNCHRONY_URI"]}/api/#{route}")
      Net::HTTP.post_form(uri, options)
    end

    def login(employee_id)
      post("sessions/#{employee_id}")
    end

    def pickup(employee_id, container_id)
      post("employees/#{employee_id}/pickup", container_id: container_id)
    end

    def dropoff(employee_id, location_id)
      post("employees/#{employee_id}/dropoff", location_id: location_id)
    end
  end

end
end
