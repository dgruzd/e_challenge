class Member < ActiveRecord::Base
  has_many :topics
  validate :valid_url
  has_shortened_urls
  before_save :create_short_url


  private
  def valid_url
    if self.website
      errors.add(self.website, 'Not valid url') unless UrlValidator.valid?(self.website)
    end
  end

  def create_short_url
    Shortener::ShortenedUrl.generate(website, self)
  end

  #def add_http
  #  if website
  #    new_website = "http://#{website}" unless website =~ /\Ahttp(s)?:\/\//
  #    if UrlValidator.valid?(new_website)
  #      self.website = new_website
  #    end
  #  end
  #end
end
