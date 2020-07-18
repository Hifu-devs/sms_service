require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/base'
require 'dotenv'
require 'json'
Dotenv.load

class Microservice < Sinatra::Base

get '/' do
  "Hello World"
end

post '/alert' do
  hifu_name = params["information"]["data"]["name"]
  phone_number = params["information"]["data"]["phone"]
  activity = params["information"]["data"]["activity"]
  email = params["information"]["data"]["email"]
  account_sid = ENV['TWILIO_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  client = Twilio::REST::Client.new(account_sid, auth_token)

  from = '+13344714617' # Your Twilio number
  to = phone_number # Your mobile phone number

  client.messages.create(
  from: from,
  to: to,
  body: "Uh oh! Your friend #{hifu_name} is has not checked in from their recent #{activity} trip.
  Check your email at #{email} for more info and instructions for contacting the authorities."
  )

end

end
# post '/sms-quickstart' do
#   twiml = Twilio::TwiML::MessagingResponse.new do |r|
#     r.message(body: 'Sorry, this phone number is not monitored.')
#   end
#
#   twiml.to_s
# end
