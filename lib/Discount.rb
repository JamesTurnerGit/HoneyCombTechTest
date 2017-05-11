class Discount
  def initialize (discounter:, targetter:, condition:)
    @discounter = discounter
    @targetter = targetter
    @condition = condition
  end

  def try_apply delivery, order
    return if !targetter.check(delivery)
    return if !condition.check(order)
    discounter.apply(delivery)
  end

  def to_string
    discounter.to_string + targetter.to_string + condition.to_string + "."
  end

  private

  attr_reader :discounter, :targetter, :condition

  def apply_discount delivery
    amount.call(delivery, amountParam)
  end

end
