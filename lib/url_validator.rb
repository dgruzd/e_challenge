class UrlValidator
  def self.valid?(url)
    valid = begin
      URI.parse(url).kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
    valid ? true : false
  end
end