module DiscountTargets
  def get targetter, params = nil
    case targetter
    when :all,nil
      return All.new params
    when :type
      return Type.new params
    else
      raise "Targetter not found"
    end
  end

  module_function :get

  class Targetter
    def initialize params
      @params = params
    end

    def check delivery
      true
    end

    def to_string
      "on all items"
    end

    private

    attr_reader :params
  end

  class All < Targetter
  end

  class Type < Targetter
    def check item
      delivery = item[1]
      delivery.name == params[:type]
    end
    def to_string
      "on #{params[:type]} deliveries"
    end
  end
end
