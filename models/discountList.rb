require_relative "discountFactory"
class DiscountList
  attr_accessor :discounts
  def initialize (factoryClass = DiscountFactory)
    @discountFactory = factoryClass.new
    @discounts = []
  end

  def add params
    discounts << discountFactory.make(params)
  end

  private
  attr_reader :discountFactory
end
