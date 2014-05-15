module Extra
  class Item < Base
    def self.find(sku_id)
      parse_get "sellerItems/#{sku_id}"
    end
  end
end
