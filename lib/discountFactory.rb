require "discount"


class DiscountFactory
  include DiscountConditions
  # targetAllItems = Proc.new {
  #   true}
  #
  # targetType = Proc.new {|delivery,target|
  #   delivery.type == target}
  #
  #

  #
  #
  # def makeDiscount(amount:, target:, condition:,conditionParam: "")
  #   params = {amount: amount, target: target, conditionParam: conditionParam}
  #   params [:targetter] = getTargeter target
  #
  #   case condition
  #   when "orderTotal"
  #       chosenCondition = conditionOrderTotal
  #     else
  #       chosenCondition = conditionNone
  #   end
  #   params [:condition] = chosenTargetter
  #
  #   Discount.new params
  # end
  #
  # private
  # def getTargeter
  #   case target
  #   when :all
  #     return targetAllItems
  #   else
  #     return targetType
  #   end
end
