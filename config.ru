require 'rubygems'
require "bundler"

require File.join(File.dirname(__FILE__), 'lib/url_shortner.rb')
set :database_file, 'config/database.yml'

run UrlShortner
