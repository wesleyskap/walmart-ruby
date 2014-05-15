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
end
