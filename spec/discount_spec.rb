require "Discount"

describe Discount do
  context "global Discount" do
    subject (:discountAmount) {25}
    subject (:discount) {described_class.new ({amount: discountAmount})}

    it "should know what it applies to" do
      expect(discount.target).to eq global
    end

    xit "should know conditions about applying itself"

    it "should have a % amount" do
      expect(discount.amount).to eq discountAmount
    end

  end
end
