require_relative "../../spec_helper.rb"

describe 'model url' do
  describe '#shorten' do
    context 'vaid' do
      it 'generates valid slug for valid long_url' do
        url = Url.shorten(Faker::Internet.url)
        expect(url).not_to be_nil
      end

      it 'generates valid slug for valid long_url when optional slug is specified' do
        user_slug = Faker::Internet.slug
        url = Url.shorten(Faker::Internet.url, user_slug: user_slug)
        expect(url.slug).to eq(user_slug)
      end

      it 'returns existing generated slug for the same long url' do
        long_url = Faker::Internet.url
        url1 = Url.shorten(long_url)
        url2 = Url.shorten(long_url)
        expect(url1.slug).to eq(url2.slug)
      end
    end

    context 'invalid' do
      it 'does not let the user reuse the same user defined slug for a different url' do
        user_slug = Faker::Internet.slug
        Url.create(long_url: Faker::Internet.url, slug: user_slug)
        expect {
          Url.shorten(Faker::Internet.url, user_slug: user_slug)
        }.to raise_exception(ActiveRecord::RecordInvalid)
      end

      it 'does not generate record for invalid long_url' do
        expect{
          Url.shorten('temp')
        }.to raise_error(RuntimeError)
      end

      it 'does not generate records when the same host is used' do
        expect{
          Url.shorten('http://example.org/bjhg423hjg', host: 'example.org')
        }.to raise_error(RuntimeError)
      end
    end
  end
end
