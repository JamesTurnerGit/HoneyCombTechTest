require "discountConditions"

describe DiscountConditions do
  subject (:order){double("Order")}

  it "should allways pass if told :none condition" do
    condition = DiscountConditions.getCondition(:none)
    expect(condition.check(order)).to eq true
    expectedString = " with no condition"
    expect(condition.to_string).to eq expectedString
  end

  it "should check order total if told :orderPriceTotal" do
    condition = DiscountConditions.getCondition(:orderPriceTotal, {price: 50})
    allow(order).to receive(:total_cost).and_return (50)
    expect(condition.check(order)).to eq true

    allow(order).to receive(:total_cost).and_return (49)
    expect(condition.check(order)).to eq false

    expectedString = " if the total price is over 50"
    expect(condition.to_string).to eq expectedString
  end

  it "should check number of a type of item if told :orderTypeTotal" do
    condition = DiscountConditions.getCondition(:orderTypeTotal, {:type => :express,amount: 2})
    item_1 = double("express",:type => :express)
    item_2 = double("normal",:type => :normal)
    item_3 = double("express",:type => :express)
    broadcaster = double("broadcaster")
    items = [[broadcaster,item_1],[broadcaster,item_2]]

    allow(order).to receive(:items).and_return (items)
    expect(condition.check(order)).to eq false

    items << [broadcaster,item_3]
    expect(condition.check(order)).to eq true

    expectedString = " if there is at least 2 express deliveries in the order"
    expect(condition.to_string).to eq expectedString
  end

  it "should raise if it doesn't understand the condition type" do
    expect{DiscountConditions.itself.getCondition(:fake)}.to raise_error "condition not found"
  end
end
