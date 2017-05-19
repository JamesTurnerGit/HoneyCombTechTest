module DiscountConditions
  def get condition, params = nil
    condition ||= :none
    raise "condition matcher not found" if CONDITIONS[condition] == nil
    CONDITIONS[condition].new params
  end

  module_function :get

  class Condition
    def initialize params
      @params = params

    end
    def check order
      true
    end
    def to_s
      ""
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

    def to_s
      "if the total price is over #{params[:amount]}"
    end
  end

  class TypeTotal < Condition
    def check order
      count = order.items_of_type(params[:type]).count
      count >= params[:amount]
    end

    def to_s
      "if there is at least #{params[:amount]} #{params[:type]} deliveries in the order"
    end
  end

  class DateRange < Condition
    def check order
      order.timeStamp >= params[:startDate] &&
        order.timeStamp <= params[:endDate]
    end
  end

  CONDITIONS = {:none => None, :priceTotal => PriceTotal, :typeTotal => TypeTotal, :dateRange => DateRange}.freeze
end
