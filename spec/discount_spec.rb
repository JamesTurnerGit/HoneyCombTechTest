require "./models/discount"

describe Discount do
  subject (:amount) {double("AmountProc", apply: nil)}
  subject (:target) {double("TargetProc", check: true)}
  subject (:condition) {double("conditionProc", check: true)}

  subject (:params) {{discounter: amount, targetter: target, condition: condition}}

  subject (:discount) {Discount.new params}

  subject (:delivery) {double("delivery")}
  subject (:order)    {double("order")}

  describe "#try_apply" do
    it "should call subclasses to check if discount applies" do
      discount.try_apply delivery, order
      expect(target).to    have_received(:check).with(delivery)
      expect(condition).to have_received(:check).with(order)
    end

    it "should apply discount if subclasses return true" do
      discount.try_apply delivery, order
      expect(amount).to have_received(:apply).with(delivery)
    end

    it "should not apply discount if target is incorrect" do
       allow(target).to receive(:check).and_return (false)
       discount.try_apply delivery, order
       expect(amount).not_to have_received(:apply).with(delivery)
    end

    it "should not apply discount if conditions are not met" do
      allow(condition).to receive(:check).and_return (false)
      discount.try_apply delivery, order
      expect(amount).not_to have_received(:apply).with(delivery)
    end
  end

  describe "#to_string" do
    it "combines the to_strings of all the subclasses" do
      allow(amount).to receive(:to_string).and_return ("1")
      allow(target).to receive(:to_string).and_return ("2")
      allow(condition).to receive(:to_string).and_return ("3")
      expectedString = "123."
      expect(discount.to_string).to eq expectedString
    end
  end
end
