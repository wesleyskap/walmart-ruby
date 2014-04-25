require 'rest-client'
require "b2w/order"
require "b2w/version"
require "json"

module B2W
  def self.config!(config)
    @config = config
  end

  private

  def self.get(resource, params)
    puts "#{endpoint}/#{resource}?#{to_params(params)}"
    JSON.parse(RestClient::Request.execute(method: :get, url: "#{endpoint}/#{resource}?#{to_params(params)}", user: token, password: token))["#{resource}s"]
  end

  def self.endpoint
    "https://api-marketplace.submarino.com.br/#{version}"
  end

  def self.token
    @config[:token]
  end

  def self.version
    @config[:sandbox] ? "sandbox" : "v1"
  end

  def self.to_params(params)
    params.map { |key, value| "#{camel_case(key)}=#{value}" }.join "&"
  end

  def self.camel_case(key)
    key.to_s.gsub(/_\w/) { $&.upcase }.gsub(/_/, '')
  end
end
