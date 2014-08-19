module Synchrony
module Acceptance
  # Represents an administrator
  #
  # This agent leverages the api to setup and manage a production 
  # floor. In a real system, this agent would likely be given
  # an actual interface to the api (e.g. a command line or web 
  # interface) but for this simple demo the agent will interact with
  # the api via http.
  class AdminAgent < BaseAgent
    include RSpec::Matchers

    attr_accessor :app

    def initialize(app)
      @app = app
    end

    def add_containers(count)
      res = app.post("/containers", 'count' => count)
      expect(res.code).to eq("200")
    end

    def add_locations(count)
      res = app.post("/locations", "count" => count)
      expect(res.code).to eq("200")
    end
  end
end
end
