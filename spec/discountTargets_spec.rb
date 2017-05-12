require "./models/discountTargets"
describe DiscountTargets do
  let (:delivery){double("delivery")}
  describe "#get" do
    it "should allways pass if told :all condition" do
      targetter = DiscountTargets.get(:all)

      expect(targetter.check(delivery)).to eq true

    end

    it "should only target items of one type if told :type" do
      item_1 = double("express",:name => :express)
      item_2 = double("normal",:name => :normal)
      targetter = DiscountTargets.get(:type,{:type => :express})

      expect(targetter.check(["broadcaster", item_1])).to eq true
      expect(targetter.check(["broadcaster", item_2])).to eq false


    end

    it "should error if given an unknown target type" do
      expect{DiscountTargets.get(:fake)}.to raise_error "target matcher not found"
    end
  end
  describe "#to_s" do
    it "all" do
      targetter = DiscountTargets.get(:all)
      expectedString = "on all items"
      expect(targetter.to_s).to eq expectedString
    end
    it "on item types" do
      targetter = DiscountTargets.get(:type,{:type => :express})
      expectedString = "on express deliveries"
      expect(targetter.to_s).to eq expectedString
    end
  end
end
