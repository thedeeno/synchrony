require 'sinatra/base'
require 'sinatra/assetpack'
require 'haml'

module Synchrony
module Apps

  class Monitor < Base
    set :views, settings.root + "/monitor/templates"
    set :haml, format: :html5

    register Sinatra::AssetPack
    assets do
      serve '/js', from: "monitor/javascripts"
      serve '/bower_components', from: File.join(Synchrony.root, "bower_components")
      serve '/css',    from: 'monitor/stylesheets'

      js :application, [
        '/bower_components/d3/d3.js',
        '/bower_components/jquery/dist/jquery.js',
        '/bower_components/underscore/underscore.js',
        '/bower_components/backbone/backbone.js',
        '/js/vendor/d3-transform.js',
        '/js/preamble.js',
        '/js/helpers/find_by_id.js',
        '/js/updaters/draw_employees.js',
        '/js/updaters/draw_containers.js',
        '/js/updaters/draw_locations.js',
        '/js/animators/dropoff.js',
        '/js/animators/pickup.js',
        '/js/subscribe.js',
        '/js/main.js',
      ]

      css :application, '/css/application.css', [
        '/css/main.css'
      ]
    end

    get '/' do
      haml :monitor
    end

  end
end
end

