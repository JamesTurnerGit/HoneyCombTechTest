require "./models/discount"

describe Discount do
  let(:amount) {double("Amount", apply: nil)}
  let(:targetter) {double("Target", find: [])}
  let(:condition) {double("condition", check: true)}

  let(:params) {{discounter: amount, targetter: targetter, condition: condition}}

  subject(:discount) {Discount.new params}

  let(:delivery) {double("delivery")}
  let(:order)    {double("order",items: [])}

  describe "#try_apply" do
    it "should call conditions to check if discount applies" do
      discount.try_apply order
      expect(condition).to have_received(:check).with(order)
    end

    it "should apply discount to items targetter returns" do
      items = [["broadcaster",delivery,100]]
      allow(targetter).to receive(:find).and_return (items)
      discount.try_apply order
      expect(amount).to have_received(:apply).with(items[0])
    end

    it "should not apply discount if conditions not met" do
       allow(condition).to receive(:check).and_return (false)
       discount.try_apply order
       expect(amount).not_to have_received(:apply).with(delivery)
    end
  end

  describe "#to_s" do
    it "combines the to_ss of all the subclasses" do
      allow(amount).to receive(:to_s).and_return ("1")
      allow(targetter).to receive(:to_s).and_return ("2")
      allow(condition).to receive(:to_s).and_return ("3")
      expectedString = "1 2 3."
      expect(discount.to_s).to eq expectedString
    end
  end
end
