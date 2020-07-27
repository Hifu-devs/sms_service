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
   get '/'
   assert last_response.ok?
   assert_equal "Welcome to HIFU -- For when you want to get lost but still be found!", last_response.body
 end

  def test_sending_successfully

    post '/alert', "{\"data\":{\"id\":\"317\",\"type\":\"route\",\"attributes\":{\"activity\":\"seeing\",\"phone\":\"+17205775625\",\"name\":\"Miss Otha Swaniawski\",\"email\":\"test123@gmail.com\"}}}"
    assert last_response.ok?
    assert_equal "Message sent successfully", last_response.body
  end

  def test_missing_info
    post '/alert', "{\"data\":{\"id\":\"317\",\"type\":\"route\",\"attributes\":{\"phone\":\"+17205775625\",\"name\":\"Miss Otha Swaniawski\",\"email\":\"test123@gmail.com\"}}}"
    assert_equal 500, last_response.status
    assert_equal "Sorry, your message was not sent. There is information missing from your request. Please try again.", last_response.body
  end

  def test_incorrect_phone_number
    post '/alert', "{\"data\":{\"id\":\"317\",\"type\":\"route\",\"attributes\":{\"activity\":\"seeing\",\"phone\":\"+1705775625\",\"name\":\"Miss Otha Swaniawski\",\"email\":\"test123@gmail.com\"}}}"
    assert_equal 500, last_response.status
    assert_equal "Sorry, your message was not sent. The phone number is not formatted correctly. Please try again.", last_response.body
  end

  def test_reply_functionality
    post '/reply'
    assert last_response.ok?
    assert last_response.body.include?("Please check your email for more information. This phone number is not monitored.")
  end

end
