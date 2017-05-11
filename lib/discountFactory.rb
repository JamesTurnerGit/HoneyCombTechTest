require "discount"
require "discountTargets"
require "discountAmounts"
require "discountConditions"

class DiscountFactory
  def initialize params
    params.merge(defaults)
    @discount = params[:discount]
    @amounts = params[:amounts]
    @targets = params[:targets]
    @conditions = params [:conditions]
  end

  def make params
    discounter = amounts.get(params[:amount], params[:amountParam])
    targetter  = target.get(params[:target], params[:targetParam])
    condition  = condition.get(params[:condition], params[:conditionParam])
    #discount.new (discounter: discounter, targetter: targetter, condition: condition)
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
