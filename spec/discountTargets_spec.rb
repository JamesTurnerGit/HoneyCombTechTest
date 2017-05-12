require "./models/discountTargets"
describe DiscountTargets do
  let (:items){[]}
  describe "#get" do
    it "should return full list if told :all condition" do
      targetter = DiscountTargets.get(:all)
      expect(targetter.find(items)).to eq items
    end

    it "should only target items of one type if told :type" do
      item_1 = double("express",:name => :express)
      item_2 = double("normal",:name => :normal)

      targetter = DiscountTargets.get(:type,{:type => :express})

      expect(targetter.find([["broadcaster", item_1]]).count).to eq 1
      expect(targetter.find([["broadcaster", item_2]]).count).to eq 0
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
