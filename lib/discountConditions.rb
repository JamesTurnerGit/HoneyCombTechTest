module DiscountConditions

  def getCondition condition, params = nil
      case condition
      when :none
        return None.new params
      when :priceTotal
        return PriceTotal.new params
      when :typeTotal
        return TypeTotal.new params
      else
        raise "condition not found"
      end
  end

  module_function :getCondition

  class Condition
    def initialize params
      @params = params
    end
    def check order
      true
    end
    def to_string
      " with no condition"
    end

    private

    attr_reader :params
  end

  class None < Condition
  end

  class PriceTotal < Condition
    def check order
      order.total_cost >=  params[:price]
    end

    def to_string
      " if the total price is over #{params[:price]}"
    end
  end

  class TypeTotal < Condition
    def check order
      count = order.itemsOfType(params[:type]).count
      count >= params[:amount]
    end

    def to_string
      " if there is at least #{params[:amount]} #{params[:type]} deliveries in the order"
    end
  end
end
