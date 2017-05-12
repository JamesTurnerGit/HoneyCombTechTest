class Discount
  def initialize (discounter:, targetter:, condition:)
    @discounter = discounter
    @targetter = targetter
    @condition = condition
  end

  def try_apply order, delivery
    return if !targetter.check(delivery)
    return if !condition.check(order)
    discounter.apply(delivery)
  end

  def to_s
    "#{discounter.to_s} #{targetter.to_s} #{condition.to_s}."
  end

  private

  attr_reader :discounter, :targetter, :condition

  def apply_discount delivery
    amount.call(delivery, amountParam)
  end

end
