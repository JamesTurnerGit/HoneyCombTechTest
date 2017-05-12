require "./models/delivery"
describe Delivery do
  subject(:delivery){Delivery.new("name",5)}
  it "should set it's attributes correctly" do
    expect(delivery.name).to eq "name"
    expect(delivery.price).to eq 5
    expect(delivery.originalPrice).to eq 5
  end
  it "should allow price to change but not OriginalPrice" do
    expect{delivery.originalPrice = 10}.to raise_error NoMethodError
    delivery.price = 15
    expect(delivery.originalPrice).to eq 5
    expect(delivery.price).to eq 15
  end
  describe "#reset_price" do
    it "should reset to it's originalPrice" do
      delivery.price = 15
      delivery.reset_price
      expect(delivery.price).to eq 5
    end
  end
end
