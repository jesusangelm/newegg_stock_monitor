class HomeController < ApplicationController
  def index
    @xss_stock = Stock.xss_stock
    @xsx_stock = Stock.xsx_stock
  end
end
