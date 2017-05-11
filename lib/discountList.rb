require "discountFactory"
class DiscountList
  attr_reader :discounts
  def initialize (factoryClass = DiscountFactory)
    @discountFactory = factoryClass.new
    @discounts = []
  end

  def add params
    discounts << discountFactory.make(params)
  end

  private
  attr_writer :discounts
  attr_reader :discountFactory
end
