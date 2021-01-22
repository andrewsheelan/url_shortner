source 'https://rubygems.org'
gem 'sinatra'
gem 'sinatra-activerecord', github: 'sinatra-activerecord/sinatra-activerecord'

gem 'haml'
gem 'pg', group: :production
gem 'rake'
gem 'puma'
group :test, :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-sinatra'
  gem 'faker'
end

ruby '3.0.0'
