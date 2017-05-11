module DiscountAmounts
  def get discounter, params = nil
    case discounter
    when :percentOff
      return PercentOff.new params
    when :changePrice
      return ChangePrice.new params
    else
      raise "Discounter not found"
    end
  end

  module_function :get

  class Discounter
    def initialize params
      @params = params
    end

    def to_string
      ""
    end
    private

    attr_reader :params
  end

  class PercentOff < Discounter
    def apply item
      delivery = item[1]
      price = delivery.discountedPrice
      percentageOfOriginal = (100 - params[:amount])
      discountedPrice = price * percentageOfOriginal / 100
      delivery.discountedPrice = discountedPrice
      true
    end
    def to_string
      "#{params[:amount]}% off"
    end
  end

  class ChangePrice < Discounter
    def apply item
      delivery = item[1]
      delivery.discountedPrice = params[:amount]
      true
    end
    def to_string
      "price changed to #{params[:amount]}"
    end
  end
end
