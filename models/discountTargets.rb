module DiscountTargets
  def get targetter, params = nil
    targetter ||= :all
    raise "target matcher not found" if TARGETTERS[targetter] == nil
    TARGETTERS[targetter].new params
  end

  module_function :get

  class Targetter
    def initialize params
      @params = params
    end

    def find items
      items
    end

    def to_s
      "on all items"
    end

    private

    attr_reader :params
  end

  class All < Targetter
  end

  class Type < Targetter
    def find items
      items.select{|item| item[1].name == params[:type]}
    end

    def to_s
      "on #{params[:type]} deliveries"
    end
  end
  TARGETTERS = {:all => All,:type => Type}.freeze
end
