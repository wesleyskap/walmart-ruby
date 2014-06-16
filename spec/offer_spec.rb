require 'spec_helper'

describe Walmart::Offer do
  describe ".create!" do
    it "should persist a valid offer" do
      offer = VCR.use_cassette('offer_success') do
        Walmart::Offer.create! id: 1234, name: 'Walmart Ruby', description: 'Walmart Ruby gem', active: true, ean: '1234567890123', sellerSKU: '1234567', height: 10, width: 5, weight: 1, price: 12.45, priceDiscount: 10, brand: 'i-Supply', urlImage: "http://images.isupply.com.br/1234567"
      end
      offer.should be_persisted
    end

    it "should not persist an invalid offer" do
      offer = VCR.use_cassette('offer_not_success') do
        Walmart::Offer.create! id: 'not-long'
      end
      offer.should_not be_persisted
    end
  end
end
