module Walmart
  class Offer < Base
    def self.create!(params)
      post(:offers, params) do |body, request, result|
        new persisted: result.is_a?(Net::HTTPOK)
      end
    end
  end
end
