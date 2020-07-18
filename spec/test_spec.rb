require './microservice.rb'
require 'rack/test'


describe "My Sinatra Application" do
  include Rack::Test::Methods
  def app
    Microservice.new
  end

  it "should send text message successfully" do
    json = {"data" => {"phone"=>"+13038758190", "name"=>"John Doe", "activity"=>"kayaking", "email"=>"friend@example.com"}}
    post '/alert', :information => json
    expect(last_response).to be_ok
  end
end
