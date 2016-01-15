class UrlShortner < Sinatra::Base
  require 'json'
  # API SERVICE
  get '/:uid' do
    url   = Url.find_by(uid: params[:uid])
    if url
      redirect url.long_url
    else
      status 404
      body({ error: 'Invaid short url.' }.to_json)
    end
  end

  post '/shorten' do
    params = JSON.parse(request.body.read)
    url = Url.shorten(
      params['long_url'],
      slug: params['slug'],
      host: request.host
    )

    if url
      URI.join(request.url, url.uid).to_s
    else
      status 500
      body({ error: 'Invaid long url.' }.to_json)
    end
  end
end
