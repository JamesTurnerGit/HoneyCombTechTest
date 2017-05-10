module DiscountConditions

  def getCondition condition, params = nil
      case condition
      when :none
        return None.new params
      when :orderPriceTotal
        return OrderPriceTotal.new params
      when :orderTypeTotal
        return OrderTypeTotal.new params
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

  class OrderPriceTotal < Condition
    def check order
      order.total_cost >=  params[:price]
    end
    def to_string
      " if the total price is over #{params[:price]}"
    end
  end

  class OrderTypeTotal < Condition
    def check order
      count = order.items.select{|item| item[1].type == params[:type]}.count
      count >= params[:amount]
    end
    def to_string
      " if there is at least #{params[:amount]} #{params[:type]} deliveries in the order"
    end
  end
end
