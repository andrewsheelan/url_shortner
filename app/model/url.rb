class Url < ActiveRecord::Base
  validates_presence_of :long_url
  before_create :generate_uid
  scope :recent, -> { limit(10).order(created_at: :desc) }

  def self.shorten(long_url, host: nil)
    return if long_url.nil? || (host && long_url.include?(host))

    uri = URI.parse(long_url)
    if (uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS))
      Url.find_or_create_by(long_url: long_url)
    end
  end

  private
  def generate_uid
    begin
      uid = SecureRandom.urlsafe_base64(8)
    end while Url.where(uid: uid).exists?
    self.uid = uid
  end
end
