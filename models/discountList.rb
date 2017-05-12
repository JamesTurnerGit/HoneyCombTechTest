require_relative "discountFactory"
class DiscountList
  attr_accessor :items
  def initialize (factoryClass = DiscountFactory)
    @discountFactory = factoryClass.new
    @items = []
  end

  def apply_discounts order
    order.items.each do |item|
      item[2] = item[1].price
    end

    items.each do |discount|
      discount.try_apply(order)
    end
  end

  def add params
    items << discountFactory.make(params)
  end

  private
  attr_reader :discountFactory
end
