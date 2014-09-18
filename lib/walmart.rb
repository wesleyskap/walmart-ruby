require 'rest-client'
require "walmart/base"
require "walmart/offer"
require "walmart/order"
require "walmart/version"
require "json"

module Walmart
  def self.config!(config)
    @config = config
  end

  def self.config
    @config
  end
end
