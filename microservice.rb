require 'twilio-ruby'
require 'sinatra'

post '/alert' do
  twiml = Twilio::TwiML::MessagingResponse.new do |r|
    r.message(body: 'Ahoy! Thanks so much for your message.')
  end

  twiml.to_s
end
