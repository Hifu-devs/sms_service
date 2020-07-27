require 'sinatra'
require 'rubygems'
require 'twilio-ruby'
require 'dotenv'
require 'json'
Dotenv.load

  get '/' do
    "Welcome to HIFU -- For when you want to get lost but still be found!"
  end

  post '/alert' do
    details = JSON.parse(request.body.read)
    if details["data"]["attributes"]["name"].nil? || details["data"]["attributes"]["phone"].nil? || details["data"]["attributes"]["activity"].nil? || details["data"]["attributes"]["email"].nil?
  	   halt 500, "Sorry, your message was not sent. There is information missing from your request. Please try again."
    elsif details["data"]["attributes"]["phone"].length != 12
       halt 500, "Sorry, your message was not sent. The phone number is not formatted correctly. Please try again."
    else
      hifu_name = details["data"]["attributes"]["name"]
      phone_number = details["data"]["attributes"]["phone"]
      activity = details["data"]["attributes"]["activity"]
      email = details["data"]["attributes"]["email"]
      account_sid = ENV['TWILIO_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      client = Twilio::REST::Client.new(account_sid, auth_token)

      from = '+13344714617' # Your Twilio number
      to = phone_number # Emergency Contact's Phone Number
      client.messages.create(
        from: from,
        to: to,
        body: "Uh oh! Your friend #{hifu_name} has not checked in from their recent #{activity} trip. Check your email at #{email} for more info and instructions for contacting the authorities."
      )
          response.body = "Message sent successfully"
    end
  end

  post '/reply' do
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: 'Please check your email for more information. This phone number is not monitored.')
    end

    twiml.to_s
  end
