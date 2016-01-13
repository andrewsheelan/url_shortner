require 'rubygems'
require 'sinatra'
require 'haml'
require 'sinatra/activerecord'
Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each { |f| load(f) }

set :views, Proc.new { File.join(root, 'app', 'views') }
get '/urls' do
  haml 'urls/index'
end

get '/urls/:url_id' do
  @url = Url.friendly.find(params[:id])
  redirect @url.full_url
end

post '/urls' do

end
