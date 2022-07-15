source 'https://rubygems.org'

gem 'active_storage_validations'
gem 'binding_of_caller'
gem 'bullet'
gem 'coffee-rails'
gem 'devise'
gem 'devise_invitable'
gem 'devise-two-factor'
gem 'diffy'
gem 'doorkeeper'
gem 'doorkeeper-i18n'
gem "down", "~> 5.0"
gem 'exception_handler'
gem 'flamegraph'
gem 'gutentag'
gem 'icalendar'
gem 'image_processing'
gem 'loaf'
gem 'lockbox'
gem 'memory_profiler'
gem 'minidusen'
gem 'mini_magick'
gem 'net-http-persistent'
gem 'pagy'
gem 'paperclip'
gem 'paper_trail'
gem 'paranoia'
gem 'rack-cors', require: 'rack/cors'
gem 'rack-mini-profiler'
gem 'rails', '<7'
gem 'rails-i18n'
gem 'rails_heroicons'
gem 'ransack'
gem 'rb-readline'
gem 'rqrcode'
gem 'secure_headers', '~> 6.3'
gem 'sprockets'
gem 'stackprof'
gem 'tailwindcss-rails-webpacker', "~> 0.2.1"
gem 'turbo-rails'
gem 'tzinfo'
gem 'uglifier'
gem "webpacker"
gem 'wine_bouncer'

group :production, :development do
  gem 'mysql2'
end

group :development, :test do
  gem 'puma'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :production, :staging do
  gem "honeybadger", "~> 4.0"
  gem "redis", "~> 4.0"
  gem 'whenever', require: false
end

group :development do
  gem 'any_login'
  gem "brakeman", require: false
  gem 'web-console'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'shoulda-context'
  gem 'sqlite3'
  gem 'webdrivers'
end

group :bundler do
  gem 'matrix', require: false
  gem 'net-imap', require: false
  gem 'net-pop', require: false
  gem 'net-smtp', require: false
end
