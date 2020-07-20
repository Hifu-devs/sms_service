ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require './microservice'

# module RSpecMixin
#   include Rack::Test::Methods
#   def app() described_class end
# end
# 
# RSpec.configure { |c| c.include RSpecMixin }
