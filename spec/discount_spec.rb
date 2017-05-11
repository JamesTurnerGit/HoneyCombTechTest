require "discount"

describe Discount do
    subject (:amount) {double("AmountProc", apply: nil)}
    subject (:target) {double("TargetProc", check: true)}
    subject (:condition) {double("conditionProc", check: true)}

    subject (:params) {{discounter: amount, targetter: target, condition: condition}}

    subject (:discount) {Discount.new params}

    subject (:delivery) {double("delivery")}
    subject (:order)    {double("order")}

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
