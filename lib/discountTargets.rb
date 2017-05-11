module DiscountTargets
  def get targetter, params = nil
    case targetter
    when :all
      return OnAll.new params
    when :type
      return ByType.new params
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
      " on all items"
    end

    private

    attr_reader :params
  end

  class OnAll < Targetter
  end

  class ByType < Targetter
    def check delivery
      delivery.type == params[:type]
    end
    def to_string
      " on #{params[:type]} deliveries"
    end
  end
end
