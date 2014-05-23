require 'spec_helper'

describe Extra::Item do
  describe ".find" do
    it "find an item by the Extra sku id" do
      VCR.use_cassette('items_find') do
        Extra::Item.find('3454385')['skuOrigin'].should == '219802'
      end
    end

    it "find an item by the origin sku id" do
      VCR.use_cassette('items_find_by_origin_sku') do
        Extra::Item.find('origin_sku' => '219802')['skuId'].should == '3454385'
      end
    end
  end
end
