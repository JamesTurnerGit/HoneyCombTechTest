require "./models/delivery"
describe Delivery do
  subject(:delivery){Delivery.new("name",5)}
  it "should set it's attributes correctly" do
    expect(delivery.name).to eq "name"
    expect(delivery.price).to eq 5
    expect(delivery.discountedPrice).to eq 5
  end
  it "should allow discountedPrice to change but not price" do
    expect{delivery.price = 10}.to raise_error NoMethodError
    delivery.discountedPrice = 15
    expect(delivery.price).to eq 5
    expect(delivery.discountedPrice).to eq 15
  end
end
