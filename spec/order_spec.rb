require 'spec_helper'

describe Extra::Order do
  describe ".unapproved" do
    it "returns the new orders details" do
      VCR.use_cassette('orders_unapproved') do
        Extra::Order.unapproved.first['orderId'].should == '219801'
      end
    end
  end

  describe ".approved" do
    it "returns the approved orders details" do
      VCR.use_cassette('orders_approved') do
        Extra::Order.approved.first["totalAmount"].should == 457.8
      end
    end
  end

  describe ".canceled" do
    it "returns the canceled orders details" do
      VCR.use_cassette('orders_canceled') do
        Extra::Order.canceled.first["purchaseDate"].should == "2014-05-13T22:14:39.000-03:00"
      end
    end
  end

  describe ".track!" do
    it "returns the new orders details" do
      VCR.use_cassette('orders_track') do
        Extra::Order.new('id' => "219801").track!(orderItemId: ["21932894-1"], controlPoint: 'EPR', occurenceDt: '2014-05-21 00:00:00.00', carrierName: 'Carrie', originDeliveryId: 'SW896927135BR', accessKeyNfe: '35140513933305000289550010000594411422441779')['status'].should == '1'
      end
    end
  end
end
