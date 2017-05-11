require "discountAmounts"
describe DiscountAmounts do
  subject (:delivery){double("delivery",price: 100, :discountedPrice= =>nil)}

  it "should change the price if told :changePrice" do
    amount = rand(5..100)
    discounter = DiscountAmounts.get(:changePrice,{amount: amount})
    discounter.apply(delivery)
    expect(delivery).to have_received(:discountedPrice=).with(amount)
  end

  it "should reduce by a % if told :percentOff" do
    amount = 25
    discounter = DiscountAmounts.get(:percentOff,{amount: amount})
    discounter.apply(delivery)
    expect(delivery).to have_received(:discountedPrice=).with(75)
  end

  it "should error if given an unknown target type" do
    expect{DiscountAmounts.get(:fake)}.to raise_error "Discounter not found"
  end

  describe "#to_string" do
    it "changePrice" do
      amount = 50
      discounter = DiscountAmounts.get(:changePrice,{amount: amount})
      expectedString = "price changed to #{amount} for "
      expect(discounter.to_string).to eq expectedString
    end
    it "PercentOff" do
      amount = 50
      discounter = DiscountAmounts.get(:percentOff,{amount: amount})
      expectedString = "#{amount}% off "
      expect(discounter.to_string).to eq expectedString
    end
  end
end