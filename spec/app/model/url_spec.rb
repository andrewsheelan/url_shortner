require_relative "../../spec_helper.rb"

describe 'model url' do
  describe '#shorten' do
    it 'generates valid uid for valid long_url' do
      url = Url.shorten(Faker::Internet.url)
      expect(url).not_to be_nil
    end

    it 'does not generate record for invalid long_url' do
      url = Url.shorten('temp')
      expect(url).to be_nil
    end

    it 'does not generate record for same host' do
      url = Url.shorten('http://example.org/bjhg423hjg', host: 'example.org')
      expect(url).to be_nil
    end

  end
end
