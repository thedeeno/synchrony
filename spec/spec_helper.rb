require 'synchrony'
require 'database_cleaner'

RSpec.configure do |c|
  ActiveRecord::Base.logger = nil

  c.before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start 
  end

  c.after do
    DatabaseCleaner.clean
  end
end

