require 'spec_helper'

describe Extra::Item do
  describe ".find" do
    it "find an item by the sku id" do
      VCR.use_cassette('items_find') do
        Extra::Item.find('3454385')['skuOrigin'].should == '219802'
      end
    end
  end
end
