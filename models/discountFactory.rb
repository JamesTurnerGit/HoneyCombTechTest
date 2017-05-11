require_relative "discount"
require_relative "discountTargets"
require_relative "discountAmounts"
require_relative "discountConditions"

class DiscountFactory
  def initialize params = {}
    params = defaults.merge(params)
    @discount = params[:discount]
    @amounts = params[:amounts]
    @targets = params[:targets]
    @conditions = params [:conditions]
  end

  def make params
    discounter = amounts.get(params[:amount], params[:amountParam])
    targetter  = targets.get(params[:target], params[:targetParam])
    condition  = conditions.get(params[:condition], params[:conditionParam])
    discount.new ({discounter: discounter, targetter: targetter, condition: condition})
  end

  private
  def defaults
    {discount: Discount,
     amounts: DiscountAmounts,
     targets: DiscountTargets,
     conditions: DiscountConditions}
  end
  attr_reader :discount, :amounts, :targets, :conditions
end
