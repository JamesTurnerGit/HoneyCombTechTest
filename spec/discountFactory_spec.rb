require "./models/discountFactory"
describe DiscountFactory do
  let(:discount){double("discount", new: nil)}
  let(:amounts){double("amounts", get: "amountClass")}
  let(:targets){double("targets", get: "targetClass")}
  let(:conditions){double("conditions", get: "conditionClass")}

  subject(:discountFactory){described_class.new({discount: discount,
                                                 amounts: amounts,
                                                 targets: targets,
                                                 conditions: conditions})}
  let(:discountParams){{amount: "amount", amountParam: "amountParam",
                        target: "target", targetParam: "targetParam",
                        conditions:[{condition: "condition", conditionParam: "conditionParam"}]}}
  describe "#make" do
    it "searches the right modules for the right parts" do
      discountFactory.make discountParams
      expect(amounts).to have_received(:get).with("amount","amountParam")
      expect(targets).to have_received(:get).with("target","targetParam")
      expect(conditions).to have_received(:get).with("condition","conditionParam")
    end
    it "passes on the right parts" do
      discountFactory.make discountParams
      expect(discount).to have_received(:new).with({discounter:"amountClass",
                                                    targetter: "targetClass",
                                                    conditions: ["conditionClass"]})
    end
    ##TODO write a nice test for multi conditions
  end
end
