require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe "Examples" do
  let(:site_discounts){DiscountList.new}
  let(:broadcaster_1){ Broadcaster.new(1, 'Viacom')}
  let(:broadcaster_2){ Broadcaster.new(2, 'Disney')}
  let(:broadcaster_3){ Broadcaster.new(3, 'Discovery')}
  let(:broadcaster_4){ Broadcaster.new(4, 'ITV')}
  let(:broadcaster_5){ Broadcaster.new(5, 'Channel 4')}
  let(:broadcaster_6){ Broadcaster.new(6, 'Bike Channel')}
  let(:broadcaster_7){ Broadcaster.new(7, 'Horse and Country')}
  let(:standard_delivery){ Delivery.new(:standard, 10.0)}
  let(:express_delivery){ Delivery.new(:express, 20.0)}

  before(:each) do
    site_discounts.add ({:amount => :changePrice,  amountParam: {amount: 15.0},
                         :target => :type,         targetParam: {:type => :express},
                         :condition => :typeTotal, conditionParam: {amount: 2, :type => :express}})
    site_discounts.add ({:amount => :percentOff,   amountParam: {amount:10},
                         :condition => :priceTotal,conditionParam: {amount: 30}})
  end

  it "calculates example1 as expected" do
    material = Material.new('WNP/SWCL001/010')
    order = Order.new(material,site_discounts)

    order.add broadcaster_1, standard_delivery
    order.add broadcaster_2, standard_delivery
    order.add broadcaster_3, standard_delivery

    order.add broadcaster_7, express_delivery

    expect(order.discounted_total_cost).to eq 45.0

  end
  it "calculates example2 as expected" do
    material = Material.new('ZDW/EOWW005/010')
    order = Order.new(material,site_discounts)
    order.add broadcaster_1, express_delivery
    order.add broadcaster_2, express_delivery
    order.add broadcaster_3, express_delivery

    expect(order.discounted_total_cost).to eq 40.5
  end
end
