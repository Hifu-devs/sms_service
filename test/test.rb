ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require './microservice'

class MicroserviceTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_hello_world
   skip
   get '/'
   assert last_response.ok?
   assert_equal "``````Welcome to HIFU -- For when you want to get lost but still be found!``````", last_response.body
 end

  def test_sending_successfully
    post '/alert', {"phone"=> "+13038758190", "name"=> "John Doe", "activity"=> "kayaking", "email"=> "friend@example.com"}.to_json
    assert last_response.ok?
    assert_equal "Message sent successfully", last_response.body
  end

  def test_missing_info
    post '/alert', {"phone"=> "+13038758190", "activity"=> "kayaking", "email"=> "friend@example.com"}.to_json
    assert_equal 500, last_response.status
    assert_equal "Sorry, your message was not sent. There is information missing from your request. Please try again.", last_response.body
  end

  def test_incorrect_phone_number
    post '/alert', {"phone"=> "+1303875819", "name"=> "John Doe", "activity"=> "kayaking", "email"=> "friend@example.com"}.to_json
    assert_equal 500, last_response.status
    assert_equal "Sorry, your message was not sent. The phone number is not formatted correctly. Please try again.", last_response.body
  end

  def test_reply_functionality
    post '/sms-quickstart'
    assert last_response.ok?
    assert_equal "Hifu Reply Sent", last_response.body
  end

end
