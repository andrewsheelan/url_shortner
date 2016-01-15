require_relative "../spec_helper.rb"

describe 'API Service Paths' do
  describe 'GET /{short_id}' do
    let(:url){ Url.create(long_url: Faker::Internet.url) }
    it 'is should redirect' do
      get "/#{url.uid}"
      expect(last_response.status).to eq 302
    end
    it 'is should return not found if invalid' do
      get "/#{url.uid}123"
      expect(last_response.status).to eq 404
    end
  end

  describe 'POST /shorten' do
    it 'is should create a short url' do
      post "/shorten", long_url: Faker::Internet.url
      expect(last_response.status).to eq 200
    end

    it 'is should reuse the same uid for existing urls' do
      long_url = Faker::Internet.url
      existing_url = Url.create long_url: long_url
      post "/shorten", long_url: long_url
      expect(last_response.body).to include existing_url.uid
    end

    it 'is should return invalid if invalid url is entered' do
      post "/shorten", long_url: 123
      expect(last_response.status).to eq 500
    end

    it 'is should return invalid if host url is entered' do
      post "/shorten", long_url: 'http://example.org/temp'
      expect(last_response.status).to eq 500
    end
  end

  describe 'GET /' do
    before { get '/' }
    it 'is successful' do
      expect(last_response.status).to eq 200
    end
  end
end
