
class Discount
  def initialize (amount:,amountParam:,
                  target:,targetParam:,
                  condition:,conditionParam:,
                  string: "")
    self.amount = amount
    self.amountParam = amountParam
    self.target = target
    self.targetParam = targetParam
    self.condition = condition
    self.conditionParam = conditionParam
    self.string = string
  end

  def try_apply delivery, order
    matchesTarget = target.call(delivery, targetParam)
    matchesConditions = condition.call(order, conditionParam)
    apply_discount(delivery) if matchesTarget && matchesConditions
  end

  def to_string
    string
  end

  private

  attr_accessor :amount,:amountParam,
                :target, :targetParam,
                :condition, :conditionParam,
                :string

  def apply_discount delivery
    amount.call(delivery, amountParam)
  end

end
