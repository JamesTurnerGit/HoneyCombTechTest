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
    end

    items.each do |discount|
      ObjectSpace.each_object(Delivery) do |item|
        discount.try_apply(order,["thing",item])
      end
    end
  end

  def add params
    items << discountFactory.make(params)
  end

  private
  attr_reader :discountFactory
end
