class UrlShortner < Sinatra::Base
  # API SERVICE
  get '/:uid' do
    url = Url.find_by(uid: params[:uid])
    if url
      redirect url.long_url
    else
      status 404
      body 'Invaid short url.'
    end
  end

  post '/shorten' do
    url = Url.shorten(
      params[:long_url],
      host: request.host
    )

    if url
      URI.join(request.url, url.uid).to_s
    else
      status 500
      body 'Invaid long url.'
    end
  end
end
