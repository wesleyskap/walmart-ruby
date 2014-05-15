require 'spec_helper'

describe Extra::Product do
  describe ".create!" do
    xit "should persist a valid product" do
      product = VCR.use_cassette('product_success') do
        Extra::Product.create!(id: 'extra-ruby-1', name: 'Extra Ruby', sku: [{ id: 'extra-ruby-1', name: 'Extra Ruby', ean: ['1234567890128'], weight: 1, stockQuantity: 3, enable: true, price: { sellPrice: 10, listPrice: 10 }}], manufacturer: { name: 'Digital Pages', model: 'extra-ruby', warrantyTime: 1 }, deliveryType: 'SHIPMENT', nbm: { number: '49019900', origin: '1' })
      end
      product.should be_persisted
    end

    xit "should not persist an invalid product" do
      product = VCR.use_cassette('product_not_success') do
        Extra::Product.create!(id: 'extra-ruby-2', name: 'Extra Ruby', sku: [{ id: 'extra-ruby-2', name: 'Extra Ruby', ean: ['invalid'], weight: 1, stockQuantity: 3, enable: true, price: { sellPrice: 10, listPrice: 10 }}], manufacturer: { name: 'Digital Pages', model: 'extra-ruby', warrantyTime: 1 }, deliveryType: 'SHIPMENT', nbm: { number: '49019900', origin: '1' })
      end
      product.should_not be_persisted
    end
  end
end
