require './microservice.rb'
require 'rack/test'



describe "My Sinatra Application" do
  include Rack::Test::Methods
  def app
    Microservice.new
  end

  it "should send text message successfully" do
    user_data = { "phone" => "+13038758190",
                  "name" => "John Doe",
                  "activity" => "kayaking",
                  "email" => "friend@example.com" }
    post '/alert', user_data
    expect(last_response).to be_ok
  end
end
