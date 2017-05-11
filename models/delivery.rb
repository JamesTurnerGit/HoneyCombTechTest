class Delivery
  attr_accessor :name, :discountedPrice
  attr_reader :price

  def initialize(name, price)
    self.name = name
    @price = price
    self.discountedPrice = price
  end

  def reset_price
    discountedPrice = price
  end
end
