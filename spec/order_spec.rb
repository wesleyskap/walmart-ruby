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
end
