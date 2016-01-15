class UrlShortner < Sinatra::Base
  # VIEWS FOR THE SERVICE
  set :views, Proc.new {
    File.join(root, 'app', 'views')
  }

  get '/' do
    haml :'urls/index'
  end

  post '/submit_shorten' do
    @short_url = Url.shorten(
      params[:long_url],
      host: request.host
    )
    haml :'urls/index'
  end

  get '/assets/:file' do
    send_file(
      File.join(
        ROOT_DIR,
        'app', 'views', 'assets', params[:file]
      ),
      disposition: 'inline'
    )
  end
end
