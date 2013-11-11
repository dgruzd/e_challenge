class Member < ActiveRecord::Base
  has_many :topics, dependent: :delete_all
  has_many :friendships
  #has_many :friends, through: :friendships
  has_shortened_urls

  validate :valid_url

  after_save :create_short_url, :create_topics

  def friends
    Member.joins('INNER JOIN friendships ON members.id = friendships.friend_id OR members.id = friendships.member_id').
        where('(friendships.member_id = :id OR friendships.friend_id = :id) AND members.id != :id',:id => self.id).where(nil)
  end

  def short_url_key
    shortened_urls.last.try(:unique_key)
  end

  def create_topics
    get_topics.each do |t|
      self.topics.create!(level: t[:level], title: t[:title]) unless t[:title].blank?
    end
  end

  def get_topics
    res = []
    require 'open-uri'
    n = Nokogiri::HTML(open(website))
    n.css('h1,h2,h3').each do |node|
      level = node.name[/\d/].to_i
      res << {level: level, title: node.text.strip}
    end
    res
  rescue OpenURI::HTTPError
    res
  end

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
