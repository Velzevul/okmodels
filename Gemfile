source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'paperclip'
gem 'meta_search'
gem 'devise'
gem 'cancan'
gem 'thin'
gem 'foreman'

group :production do
  gem 'pg'
  gem 'aws-sdk'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'sqlite3'
end

group :test do
  gem 'capybara'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'libv8', '~> 3.11.8'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'