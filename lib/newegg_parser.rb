require 'scrapper'

class NeweggParser
  XBOX_NEWEGG_SELLER_LIST = 'https://www.newegg.com/p/pl?d=xbox+series+x&N=8000'
  CONSOLE_TYPE_REGEX = { xsx: / Xbox Series X /i, xss: / Xbox Series S /i }
  NO_STOCK_REGEX = /OUT OF Stock/i
  ITEM_PROMO_REGEX = /This item can only be purchased with a combo/i

  attr_accessor :console_type

  def initialize(console_type = :xsx)
    @console_type = console_type
  end

  def download_dom
    scrapper = Scrapper.new(XBOX_NEWEGG_SELLER_LIST)
    scrapper.request_html
  end

  def is_requested_item?(dom, console_regex)
    console_regex.match?(dom.css(".item-info").css("a").text) && !ITEM_PROMO_REGEX.match?(dom.css('div.item-info p.item-promo').text)
  end

  def is_oos?(dom)
    dom.at_css(".item-promo") && NO_STOCK_REGEX.match?(dom.css(".item-promo").text) 
  end

  def find_stock
    regex = CONSOLE_TYPE_REGEX[@console_type]
    html_dom = download_dom

    xsx_list = []
    available_stock = []

    html_dom.css(".item-cell").each {|item|  xsx_list << item if is_requested_item?(item, regex)  }
    xsx_list.each {|item| available_stock << item unless is_oos?(item) }

    available_stock
  end

  def generate_list
    stock_list = find_stock
    list = []
    stock_list.each do |item|
      list << {
        title: item.css('.item-info a').text,
        price: item.css('.item-action ul.price li.price-current').text,
        link: item.at_css('.item-info a.item-title')['href']
      }
    end
    list
  end
end
