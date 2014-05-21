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

    private

    def self.fetch(status)
      get("orders/status/#{status}", _offset: 0, _limit: 25)
    end
  end
end
