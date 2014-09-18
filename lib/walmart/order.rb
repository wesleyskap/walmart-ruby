module Walmart
  class Order < Base
    { ship: :shipped, cancel: :cancelled }.each do |verb, state|
      define_method "#{verb}!" do |params|
        self.class.post("orders/#{self[:order_id]}/#{verb == :ship ? '' : 'cancel-'}shipping-notification", params)  do |body, request, result|
          @data[state] = result.is_a?(Net::HTTPOK)
        end
      end

      define_method "#{state}?" do
        self[state]
      end
    end
  end
end
