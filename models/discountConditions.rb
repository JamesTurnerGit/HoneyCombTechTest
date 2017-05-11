module DiscountConditions

  def get condition, params = nil
      case condition
      when :none, nil
        return None.new params
      when :priceTotal
        return PriceTotal.new params
      when :typeTotal
        return TypeTotal.new params
      else
        raise "condition not found"
      end
  end

  module_function :get

  class Condition
    def initialize params
      @params = params
    end
    def check order
      true
    end
    def to_string
      "with no condition"
    end

    private

    attr_reader :params
  end

  class None < Condition
  end

  class PriceTotal < Condition
    def check order
      order.total_cost >=  params[:amount]
    end

    def to_string
      "if the total price is over #{params[:amount]}"
    end
  end

  class TypeTotal < Condition
    def check order
      count = order.items_of_type(params[:type]).count
      count >= params[:amount]
    end

    def to_string
      "if there is at least #{params[:amount]} #{params[:type]} deliveries in the order"
    end
  end
end
