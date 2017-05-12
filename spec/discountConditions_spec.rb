require "./models/discountConditions"

describe DiscountConditions do
  subject (:order){double("Order")}
  describe "#get" do
    it "should allways pass if told :none condition" do
      condition = DiscountConditions.get(:none)
      expect(condition.check(order)).to eq true
    end

    it "should check order total if told :priceTotal" do
      condition = DiscountConditions.get(:priceTotal, {amount: 50})
      allow(order).to receive(:total_cost).and_return (50)
      expect(condition.check(order)).to eq true

      allow(order).to receive(:total_cost).and_return (49)
      expect(condition.check(order)).to eq false
    end

    it "should check number of a type of item if told :typeTotal" do
      condition = DiscountConditions.get(:typeTotal, {:type => :express,amount: 3})

      items = [1,2]

      allow(order).to receive(:items_of_type).and_return (items)
      expect(condition.check(order)).to eq false

      items << 3
      expect(condition.check(order)).to eq true
    end

    it "should raise if it doesn't understand the condition type" do
      expect{DiscountConditions.itself.get(:fake)}.to raise_error "condition matcher not found"
    end
  end

  describe "#to_s" do
    it "none" do
      condition = DiscountConditions.get(:none)
      expectedString = ""
      expect(condition.to_s).to eq expectedString
    end

    it "priceTotal" do
      condition = DiscountConditions.get(:priceTotal, {amount: 50})
      expectedString = "if the total price is over 50"
      expect(condition.to_s).to eq expectedString
    end

    it "typeTotal" do
      condition = DiscountConditions.get(:typeTotal, {:type => :express,amount: 3})
      expectedString = "if there is at least 3 express deliveries in the order"
      expect(condition.to_s).to eq expectedString
    end
  end
end
