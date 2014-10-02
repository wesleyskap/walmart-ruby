require 'spec_helper'

describe Walmart::Offer do
  describe ".endpoint" do
    before :each do
      @config = Walmart.config 
    end

    it 'should include http://adapter.waldev.com.br when sandbox' do
      Walmart.config! sandbox: true
      expect(Walmart::Offer.endpoint).to include("http://adapter.waldev.com.br")
    end  

    it 'should include https://api-mp.walmart.com.br when not sandbox' do
      Walmart.config! sandbox: false
      expect(Walmart::Offer.endpoint).to include("https://api-mp.walmart.com.br")
    end  

    after :each do
      Walmart.config! @config
    end
  end

  describe ".find" do
    it 'should find an offer' do
      VCR.use_cassette('offer_find') do
        expect(Walmart::Offer.find('1234567')['name']).to eql('Walmart Ruby')
      end
    end
  end

  describe ".create!" do
    it "should persist a valid offer" do
      offer = VCR.use_cassette('offer_success') do
        Walmart::Offer.create! id: 1234, name: 'Walmart Ruby', description: 'Walmart Ruby gem', active: true, ean: '1234567890123', sellerSKU: '1234567', height: 10, width: 5, weight: 1, price: 12.45, priceDiscount: 10, brand: 'i-Supply', urlImage: "http://images.isupply.com.br/1234567"
      end
      expect(offer).to be_persisted
    end

    it "should not persist an invalid offer" do
      offer = VCR.use_cassette('offer_not_success') do
        Walmart::Offer.create! id: 'not-long'
      end
      expect(offer).to_not be_persisted
    end

    it 'should not verify the ssl as currently is invalid' do
      expect(RestClient::Request).to receive(:execute) do |params|
        expect(params[:verify_ssl]).to be_falsy
      end
      Walmart::Offer.create! id: 'not-long'
    end
  end

  describe "#update_price!" do
    it "should update an offer price" do
      offer = Walmart::Offer.new(sku: '1234567')
      VCR.use_cassette('offer_price_success') do
        expect(offer.update_price!(15.00, listPrice: 20.00)).to be_truthy
      end
    end
  end

  describe "#update_quantity!" do
    it "should update an offer quantity" do
      offer = Walmart::Offer.new(sku: '1234567')
      VCR.use_cassette('offer_quantity_success') do
        expect(offer.update_quantity!(4)).to be_truthy
      end
    end
  end
end
