require_relative "discountList"

class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8,
    discounted_price: 20
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

  def apply_discounts
    discountList.apply_discounts self
  end

  def total_cost
    items.inject(0) { |memo, (_, delivery)| memo += delivery.originalPrice }
  end

  def discounted_total_cost
    apply_discounts
    items.inject(0) { |memo, (_, delivery,discountedPrice)| memo += discountedPrice }
  end

  def output
    apply_discounts
    [].tap do |result|
      result << "Order for #{material.identifier}:"

      discountList.items.each do |discount|
        result << discount.to_s
      end

      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator

      items.each_with_index do |(broadcaster, delivery,price), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{delivery.price}").ljust(COLUMNS[:price]),
          ("$#{price}").ljust(COLUMNS[:discounted_price])
        ].join(' | ')
      end

      result << output_separator
      result << "Total: $#{total_cost}"
      result << "Total after discounts: $#{discounted_total_cost}"
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
