require 'rest-client'
require "extra/base"
require "extra/order"
require "extra/product"
require "extra/version"
require "json"

module Extra
  def self.config!(config)
    @config = config
  end

  def self.config
    @config
  end
end
