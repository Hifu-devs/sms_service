require './microservice.rb'
require 'rack/test'

describe "My Sinatra Application" do
  include Rack::Test::Methods
  def app
    Microservice.new
  end

  it "should send text message successfully" do
    post '/alert', {"phone"=> "+13038758190", "name"=> "John Doe", "activity"=> "kayaking", "email"=> "friend@example.com"}.to_json
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Message sent successfully")
  end

  it "should not send a text message if information is missing" do
    post '/alert', {"phone"=> "+13038758190", "activity"=> "kayaking", "email"=> "friend@example.com"}.to_json
    expect(last_response.status).to eq(500)
    expect(last_response.body).to eq("Sorry, your message was not sent. There is information missing from your request. Please try again.")
  end

  it "should not send a text message if phone number is formatted incorrectly" do
    post '/alert', {"phone"=> "+1303875819", "name"=> "John Doe", "activity"=> "kayaking", "email"=> "friend@example.com"}.to_json
    expect(last_response.status).to eq(500)
    expect(last_response.body).to eq("Sorry, your message was not sent. The phone number is not formatted correctly. Please try again.")
  end
end
