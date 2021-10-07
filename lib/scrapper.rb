require 'nokogiri'
require 'open-uri'

class Scrapper
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def request_html
    html = URI.parse(url).open
    Nokogiri::HTML(html)
  end
end
