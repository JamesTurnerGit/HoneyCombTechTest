module DiscountAmounts
  def get discounter, params = nil
    raise "discount method not found" if AMOUNTS[discounter] == nil
    AMOUNTS[discounter].new params
  end

  module_function :get

  class Discounter
    def initialize params
      @params = params
    end

    def to_s
      ""
    end
    private

    attr_reader :params
  end

  class PercentOff < Discounter
    def apply item
      delivery = item[1]
      price = item[2]
      percentageOfOriginal = (100 - params[:amount])
      discountedPrice = price * percentageOfOriginal / 100
      item[2] = discountedPrice
    end
    def to_s
      "#{params[:amount]}% off"
    end
  end

  class ChangePrice < Discounter
    def apply item
      delivery = item[1]
      delivery.price = params[:amount]
      item[2] = params[:amount]
    end
    def to_s
      "price changed to #{params[:amount]}"
    end
  end

  AMOUNTS = {:percentOff => PercentOff, :changePrice => ChangePrice}.freeze
end
