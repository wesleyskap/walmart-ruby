module Walmart
  class Base
    def [](key)
      @data[key]
    end

    def initialize(data)
      @data = data
    end

    def persisted?
      self[:persisted]
    end

    def self.get(path, params = {})
      [parse_get("#{path}?#{to_params(params)}")].flatten.map { |params| new params }
    end

    def self.parse_get(path)
      JSON.parse execute(:get, path)
    end

    def self.post(path, body, &block)
      execute(:post, path, body: body, &block)
    end

    def self.execute(method, path, params = {}, &block)
      params[:payload] = JSON.generate(params[:body]) if params[:body]
      headers = { accept: 'application/json' }
      RestClient::Request.execute({ verify_ssl: false, method: method, url: "#{endpoint}/#{path}", headers: headers, user: user, password: password }.merge(params), &block)
    end

    def self.endpoint
      "#{base_url}/ws/seller/#{seller_id}"
    end

    def self.seller_id
      Walmart.config[:seller_id]
    end

    def self.user
      Walmart.config[:user]
    end

    def self.password
      Walmart.config[:password]
    end

    def self.to_params(params)
      params.map { |key, value| "#{key}=#{value}" }.join "&"
    end

    def self.camelize(key)
      key.to_s.split(/_/).map{ |word| word.capitalize }.join('')
    end

    def self.base_url
      Walmart.config[:sandbox] ? "http://adapter.waldev.com.br" : "https://api-mp.walmart.com.br"
    end
  end
end
