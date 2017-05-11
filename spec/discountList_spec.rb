require "discountList"
describe DiscountList do

  subject(:discount){double ("discount")}
  subject(:discountFactory){double("discountFactory",make:discount)}
  subject(:discountFactoryClass){double("discountFactoryClass", new: discountFactory)}
  subject(:discountList){DiscountList.new (discountFactoryClass)}
  subject(:discountParams){{}}

  describe "#add" do
    it "should pass the params onto factory" do
      discountList.add(discountParams)
      expect(discountFactory).to have_received(:make).with(discountParams)
    end
  end
  
  describe "#discounts" do
    it "should return a list of it's current discounts" do
      expect(discountList.discounts.count).to eq 0
      discountList.add(discountParams)
      expect(discountList.discounts.count).to eq 1
    end
  end
end
