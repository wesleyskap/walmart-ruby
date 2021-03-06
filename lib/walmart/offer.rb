module Walmart
  class Offer < Base
    def self.find(sku)
      get("catalog/offers/external/#{sku}").first
    end

    def self.create!(params)
      post("catalog/offers", params) do |body, request, result|
        new persisted: result.is_a?(Net::HTTPOK)
      end
    end

    def update_price!(price, listPrice:)
      put "price/#{price}/listPrice/#{listPrice}" 
    end

    def update_quantity!(quantity)
      put "quantity/#{quantity}"
    end

    def update_offer!(params)
      put "", params
    end

    private

    def put(path, params = {})
      self.class.execute :put, "catalog/offers/external/#{@data[:sku]}/#{path}", body: params do |response, request, status|
        status.class == Net::HTTPOK
      end
    end
  end
end
