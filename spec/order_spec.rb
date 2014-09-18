require 'spec_helper'

describe Walmart::Order do
  describe ".ship!" do
    it "should ship an order" do
      order = Walmart::Order.new order_id: "30000100-1"
      VCR.use_cassette('order_ship_success') do
        order.ship! items: [{ id: "294494", quantity: 1 }], trackingNumber: "SS987654321BR", courier: "Correios"
      end
      expect(order).to be_shipped
    end
  end
end
