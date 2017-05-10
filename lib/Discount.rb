
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

  def tryApply delivery, order
    matchesTarget = target.call(delivery, targetParam)
    matchesConditions = condition.call(order, conditionParam)
    applyDiscount(delivery) if matchesTarget && matchesConditions
  end

  def toString
    string
  end

  private

  attr_accessor :amount,:amountParam,
                :target, :targetParam,
                :condition, :conditionParam,
                :string

  def applyDiscount delivery
    amount.call(delivery, amountParam)
  end

end
