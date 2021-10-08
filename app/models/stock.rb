class Stock < ApplicationRecord

  belongs_to :category

  def self.xss_stock
    where(category_id: 1)
  end

  def self.xsx_stock
    where(category_id: 2)
  end
end
