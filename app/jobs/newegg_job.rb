class NeweggJob < ApplicationJob
  queue_as :newegg

  def perform(console_type)
    require_relative '../../lib/newegg_parser.rb'

    parser = NeweggParser.new(console_type)
    category = Category.find_by_name(console_type.to_s.upcase)

    current_stock = Stock.where(category_id: category.id)
    current_stock.all.delete_all if current_stock.any?

    stock = parser.generate_list
    stock.each do |item|
      Stock.create(title: item[:title], price: item[:price].delete('$').to_f, link: item[:link], category_id: category.id)
    end
  end
end
