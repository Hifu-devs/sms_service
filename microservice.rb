require 'sinatra'
require 'rubygems'
require 'twilio-ruby'
#require 'sinatra/base'
require 'dotenv'
require 'json'
Dotenv.load

#class Microservice < Sinatra::Base

get '/' do
  "Hello World"
end

post '/alert' do
  details = JSON.parse(request.body.read)
  hifu_name = details["name"]
  phone_number = details["phone"]
  activity = details["activity"]
  email = details["email"]
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

post '/sms-quickstart' do
  twiml = Twilio::TwiML::MessagingResponse.new do |r|
    r.message(body: 'Please check your email for more information. This phone number is not monitored.')
  end

  twiml.to_s
end
