class Url < ActiveRecord::Base
  validates_presence_of :long_url
  before_create :generate_uid
  scope :recent, -> { limit(10).order(created_at: :desc) }

  def self.shorten(long_url, slug: nil, host: nil)
    return if invalid_input?(long_url, host) || invalid_url?(long_url)

    if slug.nil?
      Url.find_or_create_by!(long_url: long_url, slugged: false)
    else
      Url.create!(long_url: long_url, uid: URI.escape(slug), slugged: true)
    end
  end

  private
  def self.invalid_input?(long_url, host)
    long_url.nil? || (host && long_url.include?(host))
  end

  def self.invalid_url?(long_url)
    parsed_uri = URI.parse(long_url)
    ![URI::HTTP, URI::HTTPS].include? parsed_uri.class
  end

  def generate_uid
    return unless self.uid.nil?
    begin
      uid = SecureRandom.urlsafe_base64(8)
    end while Url.where(uid: uid).exists?
    self.uid = uid
  end
end
