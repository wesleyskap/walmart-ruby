module Extra
  class Order < Base
    def self.unapproved
      fetch :new
    end

    def self.approved
      fetch :approved
    end

    def self.canceled
      fetch :canceled
    end

    def track!(params)
      JSON.parse(self.class.post("orders/#{self['id']}/ordersItems/trackings/", params))
    end

    private

    def self.fetch(status)
      get("orders/status/#{status}", _offset: 0, _limit: 100)
    end
  end
end
