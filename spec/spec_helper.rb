require 'rubygems'
require 'bundler/setup'
require 'webmock'
require 'vcr'
require 'walmart'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
end

config = YAML.load(File.read('spec/config.yml'))
Walmart.config! seller_id: config['seller_id'], user: config['user'], password: config['password'], sandbox: true
