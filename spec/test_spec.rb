require './microservice.rb'
require 'rack/test'



describe "My Sinatra Application" do
  include Rack::Test::Methods
  def app
    Microservice.new
  end

  it "should send text message successfully" do
    json = { "phone": "+19192590877", "name": "John Doe", "activity": "kayaking", "email": "friend@example.com" }
    post '/alert', :params => json
    expect(last_response).to be_ok
  end
end
