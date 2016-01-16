class UrlShortner < Sinatra::Base
  require 'json'
  # API SERVICE
  get '/:slug' do
    url   = Url.find_by(slug: params[:slug])
    if url
      redirect url.long_url
    else
      status 404
      body({ error: 'Invaid short url.' }.to_json)
    end
  end

  post '/shorten' do
    begin
      params = JSON.parse(request.body.read)
      url = Url.shorten(
        params['long_url'],
        user_slug: params['slug'],
        host: request.host
      )
      status 201
      URI.join(request.url, url.slug).to_s
    rescue => e
      status 500
      body({ error: e.message }.to_json)
    end
  end
end
