module Extra
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

    def self.get(path, params)
      JSON.parse(execute(:get, "#{path}?#{to_params(params)}")).map { |params| new params }
    end

    def self.post(path, body, &block)
      execute(:post, path, body: body, &block)
    end

    def put(resource, path, body)
      self.class.execute(:put, path, body: body)
    end

    def self.execute(method, path, params = {}, &block)
      params[:payload] = JSON.generate(params[:body]) if params[:body]
      headers = { content_type: 'application/json', :'nova-auth-token' => auth_token, :'nova-app-token' => app_token }
      RestClient::Request.execute({ method: method, url: "#{endpoint}/#{path}", headers: headers }.merge(params), &block)
    end

    def self.endpoint
      "https://#{subdomain}.extra.com.br/api/v1"
    end

    def self.app_token
      Extra.config[:app_token]
    end

    def self.auth_token
      Extra.config[:auth_token]
    end

    def self.subdomain
      Extra.config[:sandbox] ? "sandbox" : "api"
    end

    def self.to_params(params)
      params.map { |key, value| "#{key}=#{value}" }.join "&"
    end
  end
end
