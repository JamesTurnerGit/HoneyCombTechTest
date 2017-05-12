require "./models/delivery"
describe Delivery do
  subject(:delivery){Delivery.new("name",5)}
  it "should set it's attributes correctly" do
    expect(delivery.name).to eq "name"
    expect(delivery.price).to eq 5
  end
  it "should not allow price to change" do
    expect{delivery.price = 10}.to raise_error NoMethodError
    expect(delivery.price).to eq 5
  end
end
