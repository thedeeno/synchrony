ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'json'

module Synchrony

describe "Synchrony API" do
  include Rack::Test::Methods

  def app
    Synchrony::Apps::Api
  end

  before do
    # stub publisher since we're not going to start event machine
    p = double("Publisher")
    allow(p).to receive(:publish) { true }
    Synchrony.publisher = p
  end

  describe "POST sessions/:id" do
  end

  describe "POST containers" do
    it "returns 500 error on negative counts" do
      post "/containers", count: -1 
      expect(last_response).to be_server_error
    end

    it "creates given number of containers" do
      expect do
        post "/containers", count: 10
      end.to change{Container.count}.to(10)
      expect(last_response).to be_ok
    end

    it "does nothing when no count given" do
      expect do
        post "/containers"
      end.to_not change{Container.count}
      expect(last_response.status).to eq(200)
    end
  end

  describe "POST locations" do
    it "returns 500 error on negative counts" do
      post "/locations", count: -1 
      expect(last_response).to be_server_error
    end

    it "creates given number of containers" do
      expect do
        post "/locations", count: 10
      end.to change{Location.count}.to(10)
      expect(last_response).to be_ok
    end

    it "does nothing when no count given" do
      expect do
        post "/locations"
      end.to_not change{Location.count}
      expect(last_response).to be_ok
    end

  end
end

end
