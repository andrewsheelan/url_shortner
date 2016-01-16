class Url < ActiveRecord::Base
  validates_presence_of :long_url
  validates_uniqueness_of :slug

  before_create :generate_slug
  scope :recent, -> { limit(10).order(created_at: :desc) }

  def self.shorten(long_url, user_slug: nil, host: nil)
    # return if the input is invalid
    raise 'Invalid Input' if invalid_input?(long_url, host)
    raise 'Invalid Url' if invalid_url?(long_url)

    record = { long_url: long_url, slugged: false }
    # update the slug and slugged attributes if slug is present
    record.merge!(
      slug: URI.escape(user_slug),
      slugged: true
    ) unless user_slug.to_s.empty?

    Url.find_or_create_by! record
  end

  private
  def self.invalid_input?(long_url, host)
    long_url.nil? || (host && long_url.include?(host))
  end

  def self.invalid_url?(long_url)
    parsed_uri = URI.parse(long_url)
    ![URI::HTTP, URI::HTTPS].include? parsed_uri.class
  end

  def generate_slug
    return unless self.slug.nil?
    begin
      slug = SecureRandom.urlsafe_base64(8)
    end while Url.where(slug: slug).exists?
    self.slug = slug
  end
end
