require_relative "discountFactory"
class DiscountList
  attr_accessor :items
  def initialize (factoryClass = DiscountFactory)
    @discountFactory = factoryClass.new
    @items = []
  end

  def apply_discounts order
    orderItems = order.items
    orderItems.each do |item|
      item[1].reset_price
      item[2] = item[1].price

      #p item[2]
    end

    items.each do |discount|
      orderItems.each do |item|
        discount.try_apply(order,item)
      end
    end
  end

  def add params
    items << discountFactory.make(params)
  end

  private
  attr_reader :discountFactory
end
