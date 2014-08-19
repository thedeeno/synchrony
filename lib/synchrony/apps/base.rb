require 'sinatra/base'
require 'sinatra/activerecord'

module Synchrony
module Apps

  class Base < Sinatra::Base
     set :database, {adapter: "sqlite3", database: "synchrony.sqlite3"}

     get "/" do
       status_code 200
       content_type "application/json"
       { status: "ok" }.to_json
     end
  end

end
end
