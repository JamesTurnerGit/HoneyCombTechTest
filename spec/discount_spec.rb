require "./models/discount"

describe Discount do
  let(:amount) {double("AmountProc", apply: nil)}
  let(:target) {double("TargetProc", check: true)}
  let(:condition) {double("conditionProc", check: true)}

  let(:params) {{discounter: amount, targetter: target, condition: condition}}

  subject(:discount) {Discount.new params}

  let(:delivery) {double("delivery")}
  let(:order)    {double("order")}

  describe "#try_apply" do
    it "should call subclasses to check if discount applies" do
      discount.try_apply order, delivery
      expect(target).to    have_received(:check).with(delivery)
      expect(condition).to have_received(:check).with(order)
    end

    it "should apply discount if subclasses return true" do
      discount.try_apply order, delivery
      expect(amount).to have_received(:apply).with(delivery)
    end

    it "should not apply discount if target is incorrect" do
       allow(target).to receive(:check).and_return (false)
       discount.try_apply order, delivery
       expect(amount).not_to have_received(:apply).with(delivery)
    end

    it "should not apply discount if conditions are not met" do
      allow(condition).to receive(:check).and_return (false)
      discount.try_apply order, delivery
      expect(amount).not_to have_received(:apply).with(delivery)
    end
  end

  describe "#to_s" do
    it "combines the to_ss of all the subclasses" do
      allow(amount).to receive(:to_s).and_return ("1")
      allow(target).to receive(:to_s).and_return ("2")
      allow(condition).to receive(:to_s).and_return ("3")
      expectedString = "1 2 3."
      expect(discount.to_s).to eq expectedString
    end
  end
end
