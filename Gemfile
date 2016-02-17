source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2', '0.3.18'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rails_12factor', group: :production

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "figaro"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.2.3"
gem 'bower'
gem 'bower-rails'
gem 'sprockets', '2.12.3', :require => 'sprockets/railtie'
gem 'angular-rails-templates', '0.1.2'
gem 'responders', '~> 2.0'
gem 'angular_rails_csrf'
gem 'omniauth', '~> 1.2.2'
gem 'devise_token_auth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'rabl'
gem 'oj' #dependency for rabl
#gem 'memcached', '~> 1.8.0'
gem 'dalli' #Instead of memcache store use it, it claims to be 20% faster than memcache
gem 'actionpack-action_caching'  #For controller's action caching, this is what we would ever require
gem 'seed_dump' #used for creating the seed data automatically rake db:seed:dump
gem 'validates_timeliness', '~> 3.0' #For activerecord datetime validations
gem 'geokit-rails' #for geo location calculation
gem 'json' #for all JSON methods just like javascript
gem 'will_paginate', '~> 3.0.6' #For pagination, we can use specific gem for bootstrap pagination but for now we just want simple infinite scroll.
gem 'friendly_id', '~> 5.1.0'
gem 'markable', :git => 'https://github.com/effektz/markable.git', :branch => :master
gem 'ratyrate' #For rating outlets
#Below 3 are Plivo rating
gem "rest-client", "~> 1.6.7"
gem "htmlentities", "~> 4.3.1"
gem 'plivo'
gem "koala", "~> 2.2"
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'whenever', :require => false
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'

group :production do
  gem 'passenger' #will be used as a webserver in production
end