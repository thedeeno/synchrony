source "https://rubygems.org"

# application framework
gem "sinatra", "~> 1.4"

# messaging
gem "faye"

# frontend
gem "sinatra-assetpack"
gem "haml"
gem "foundation"

# orm
gem "sinatra-activerecord"
gem "sqlite3"
gem "rake"

# web server
gem "thin"

# environment management
gem "dotenv"

group :development, :test do
  gem 'pry'
  gem 'foreman'
end

group :test do
  gem "rspec", "~> 3.0"
  gem "cucumber"

  # browser automation
  gem "capybara"
  gem "selenium-webdriver"

  # repeatability
  gem "database_cleaner"
end

