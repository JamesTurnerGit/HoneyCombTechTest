class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  attr_accessor :material, :items, :discountList

  def initialize(material,discountList = DiscountList.new)
    self.material = material
    self.items = []
    self.discountList = discountList
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def add_discount params
    discountList.add params
  end

  def total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def discounted_total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.discountedPrice }
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{total_cost}"
    end.join("\n")
  end

  def items_of_type type
    items.select{|item| item[1].name == type}
  end
  private

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end
end
