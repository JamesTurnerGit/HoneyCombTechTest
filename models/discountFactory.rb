require_relative "discount"
require_relative "discountTargets"
require_relative "discountAmounts"
require_relative "discountConditions"

class DiscountFactory
  def initialize params = {}
    params = defaults.merge(params)
    @discount_class = params[:discount]
    @amounts_list = params[:amounts]
    @targets_list = params[:targets]
    @conditions_list = params [:conditions]
  end

  def make params
    discounter = amounts_list.get(params[:amount], params[:amountParam])
    targetter  = targets_list.get(params[:target], params[:targetParam])
    conditions = []
    params[:conditions].each do |config|
      conditions << conditions_list.get(config[:condition], config[:conditionParam])
    end
    discount_class.new ({discounter: discounter, targetter: targetter, conditions: conditions})
  end

  private
  def defaults
    {discount: Discount,
     amounts: DiscountAmounts,
     targets: DiscountTargets,
     conditions: DiscountConditions}
  end
  attr_reader :discount_class, :amounts_list, :targets_list, :conditions_list
end
