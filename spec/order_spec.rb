require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'

describe Order do
  subject { Order.new material,discountList }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }
  let(:discountList) {double("discountList",add: nil)}

  context 'empty' do
    it 'costs nothing' do
      expect(subject.total_cost).to eq(0)
    end
  end

  context 'with items' do
    it 'returns the total cost of all items' do
      broadcaster_1 = Broadcaster.new(1, 'Viacom')
      broadcaster_2 = Broadcaster.new(2, 'Disney')

      subject.add broadcaster_1, standard_delivery
      subject.add broadcaster_2, express_delivery

      expect(subject.total_cost).to eq(30)
    end
  end

  describe '#add discount' do
    it 'delegates to discountList' do
      params = rand(1..500)
      subject.add_discount params
      expect(discountList).to have_received(:add).with params
    end
  end

  describe '#discounted_total_cost' do
    it 'returns discounted_total' do
      subject.add "broadcaster_1", standard_delivery
      subject.add "broadcaster_2", express_delivery
      express_delivery.discountedPrice = 5
      standard_delivery.discountedPrice = 10
      expect(subject.discounted_total_cost).to eq(15)
    end
  end

  describe '#items_of_type' do
    it 'returns all items matching type' do
      subject.add "broadcaster_1", standard_delivery
      subject.add "broadcaster_1", standard_delivery
      subject.add "broadcaster_1", standard_delivery
      subject.add "broadcaster_2", express_delivery

      result = subject.items_of_type(:standard).count
      expect(result).to eq 3

      result = subject.items_of_type(:express).count
      expect(result).to eq 1
    end
  end
end
