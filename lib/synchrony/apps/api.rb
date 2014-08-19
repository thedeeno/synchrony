require 'sinatra/base'
require "sinatra/activerecord"
require "faye"

module Synchrony
module Apps

  class Api < Base
    set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

    def publisher
      # assume the faye server is running in the same process as
      # this app and therefore the same address as the request
      @publisher ||= Synchrony.publisher || Publisher.new("http://#{env["REMOTE_ADDR"]}:#{env["SERVER_PORT"]}/faye")
    end

    def publish(channel, message)
      publisher.publish(channel, message)
    end

    before do
      content_type 'application/json'
    end

    post '/sessions/:id' do
      e = Employee.find(params[:id])
      e.signed_in = true
      e.save
      publish('/employees/login', {
        'employees' => [e].to_json
      })
      status_code 200
    end

    post '/locations' do
      locations = []
      count.times{ locations << Location.create }
      publish('/locations/new', {
        'locations' => locations.to_json
      })
      status_code 200
    end

    post '/containers' do
      containers = []
      count.times{ containers << Container.create }
      publish('/containers/new', {
        'containers' => containers.to_json
      })
      status_code 200
    end

    post '/employees/:id/dropoff' do
      e = Employee.find(params[:id])
      l = Location.find(params[:location_id])
      e.dropoff_at(l)

      publish('/dropoff', {
        'employee_id' => e.id,
        'location_id' => l.id
      })

      status_code 200
    end

    post '/employees/:id/pickup' do
      e = Employee.find(params[:id])
      c = Container.find(params[:container_id])
      e.pickup(c)
      publish('/pickup', {
        'employee_id' => e.id,
        'container_id' => c.id
      })
      status_code 200
    end

    # returns valid count from params, raising error if invalid
    def count
      c = params["count"].to_i
      raise ArgumentError if c < 0
      c
    end


  end
end
end

