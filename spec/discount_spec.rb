require "discount"

describe Discount do
    subject (:amount) {double("AmountProc", call: nil)}
    subject (:amountParam) {"AmountParam"}
    subject (:target) {double("TargetProc", call: true)}
    subject (:targetParam) {"TargetParam"}
    subject (:condition) {double("conditionProc", call: true)}
    subject (:conditionParam) {"conditionParam"}
    subject (:discriptor) {"string"}
    subject (:params) {{amount: amount, amountParam: amountParam,
                        target: target, targetParam: targetParam,
                        condition: condition, conditionParam: conditionParam,
                        string: discriptor}}
    subject (:discount) {Discount.new params}

    subject (:delivery) {double("delivery")}
    subject (:order)    {double("order")}

    it "should call procs to check if discount applies" do
      discount.try_apply delivery, order
      expect(target).to    have_received(:call).with(delivery, targetParam)
      expect(condition).to have_received(:call).with(order, conditionParam)
    end

    it "should apply discount proc if procs return true" do
      discount.try_apply delivery, order
      expect(amount).to have_received(:call).with(delivery, amountParam)
    end

    it "should not apply discount proc if target is incorrect" do
      allow(target).to receive(:call).and_return (false)
      discount.try_apply delivery, order
      expect(amount).not_to have_received(:call).with(delivery, amountParam)
    end

    it "should not apply discount proc if conditions are not met" do
      allow(condition).to receive(:call).and_return (false)
      discount.try_apply delivery, order
      expect(amount).not_to have_received(:call).with(delivery, amountParam)
    end

    it "should be able to return the discriptor string passed to it on creation" do
      expect(discount.to_string).to eq discriptor
    end
end
