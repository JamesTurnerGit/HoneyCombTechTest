class Delivery
  attr_accessor :name,  :price
  attr_reader :originalPrice

  def initialize(name, price)
    self.name = name
    @originalPrice = price
    self.price = price
  end

  def reset_price
    self.price = originalPrice
  end
end
