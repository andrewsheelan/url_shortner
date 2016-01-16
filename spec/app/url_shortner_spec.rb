require_relative "../spec_helper.rb"

describe 'API Service Paths' do
  describe 'GET /{slug}' do
    let(:url){ Url.create(long_url: Faker::Internet.url) }
    it 'is should redirect' do
      get "/#{url.slug}"
      expect(last_response.status).to eq 302
    end
    it 'is should return not found if invalid' do
      get "/#{url.slug}123"
      expect(last_response.status).to eq 404
    end
  end

  describe 'POST /shorten' do
    it 'is should create a short url if optional slug not set' do
      post "/shorten", { long_url: Faker::Internet.url }.to_json
      expect(last_response.status).to eq 201
    end

    it 'is should create a short url if optional slug is set' do
      user_slug = Faker::Internet.slug
      post "/shorten", { long_url: Faker::Internet.url , slug: user_slug}.to_json
      expect(last_response.body).to include user_slug
    end

    it 'is should reuse the same slug for existing urls' do
      long_url = Faker::Internet.url
      existing_url = Url.create long_url: long_url
      post "/shorten", { long_url: long_url }.to_json
      expect(last_response.body).to include existing_url.slug
    end

    it 'is should return invalid if invalid url is entered' do
      post "/shorten", { long_url: 123}.to_json
      expect(last_response.status).to eq 500
    end

    it 'is should return invalid if host url is entered' do
      post "/shorten", { long_url: 'http://example.org/temp'}.to_json
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
