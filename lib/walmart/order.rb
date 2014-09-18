module Walmart
  class Order < Base
    def shipped?
      self[:shipped]
    end

    def ship!(params)
      self.class.post("orders/#{self[:order_id]}/shipping-notification", params)  do |body, request, result|
        @data[:shipped] = result.is_a?(Net::HTTPOK)
      end
    end
  end
end
