class Discount
  def initialize (discounter:, targetter:, conditions:)
    @discounter = discounter
    @targetter = targetter
    @conditions = conditions
  end

  def try_apply order
    conditions.each do |condition|
      return if !condition.check(order)
    end

    items = targetter.find(order.items)
    items.each do |item|
      discounter.apply(item)
    end
  end

  def to_s
    "#{discounter.to_s} #{targetter.to_s} #{conditions[0].to_s}."
  end

  private

  attr_reader :discounter, :targetter, :conditions

  def apply_discount delivery
    amount.call(delivery, amountParam)
  end

end
