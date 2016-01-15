class UrlShortner < Sinatra::Base
  # VIEWS FOR THE SERVICE
  set :views, Proc.new {
    File.join(root, 'app', 'views')
  }

  get '/' do
    haml :'urls/index'
  end

  post '/submit_shorten' do
    begin
      @short_url = Url.shorten(
        params[:long_url],
        user_slug: params['slug'],
        host: request.host
      )
    rescue => e
      @error = e.message
    end
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
