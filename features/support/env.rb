require 'bundler/setup'
require 'synchrony'
require 'capybara'
require 'rspec'
require 'dotenv'
Dotenv.load

require 'database_cleaner'
ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection({
  adapter: "sqlite3",
  database: "synchrony.sqlite3"
})

Before do
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end


require_relative 'agents'
require_relative 'browser_session'
require_relative 'app'

Capybara.default_wait_time = 5

class SynchronyWorld
  def initialize
    @people = []
  end

  def person(name)
    @people.select{|x| x.name == name}.first
  end
  alias :manager :person
  alias :employee :person
  alias :admin :person


  def application_address
    "#{ENV["SYNCHRONY_WEB_HOST"]}:#{ENV["SYNCHRONY_WEB_PORT"]}"
  end
end

World do
  SynchronyWorld.new
end

