class Member < ActiveRecord::Base
  has_many :topics
  validate :valid_url
  #before_validation :add_http

  private
  def valid_url
    [:website, :short_url].each do |attr|
      url = self.send(attr)
      errors.add(attr, 'Not valid url') unless UrlValidator.valid?(url)
    end
  end

  def add_http
    if website
      new_website = "http://#{website}" unless website =~ /\Ahttp(s)?:\/\//
      if UrlValidator.valid?(new_website)
        self.website = new_website
      end
    end
  end
end
