module DiscountAmounts
  attr_reader :discounters

  #@discounters = {percentOff: PercentOff}

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
    def apply delivery
      originalPrice = delivery.price
      percentageOfOriginal = (100 - params[:amount])
      discountedPrice = originalPrice * percentageOfOriginal / 100
      delivery.discountedPrice = discountedPrice
    end
    def to_string
      "#{params[:amount]}% off "
    end
  end

  class ChangePrice < Discounter
    def apply delivery
      delivery.discountedPrice = params[:amount]
    end
    def to_string
      "price changed to #{params[:amount]} for "
    end
  end
end
