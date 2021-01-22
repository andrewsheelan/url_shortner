require 'sinatra/base'
require 'sinatra/activerecord'
require 'tilt/haml'

class UrlShortner < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  ROOT_DIR = File.expand_path("..", File.dirname(__FILE__))
  set :root, ROOT_DIR

  # load all modules
  Dir[
    "#{ROOT_DIR}/app/**/*.rb"
  ].each { |f| require(f) }

  configure :production do
    set :haml, { ugly: true }
    set :clean_trace, true
  end

  require_relative 'routes/api'
  require_relative 'routes/views'

  # start the server if ruby file executed directly
  run! if app_file == $0
end
