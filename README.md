**Purpose**

This microservice is used to connect the Hifu API to Twilio SMS text messaging service.

**Production Endpoints**

***Send Alert to Emergency Contact***

https://hifu-sms.herokuapp.com/alert

  - Request Body should include:
    - Phone number of emergency contact as "phone."
      - This should be 12 characters and be formatted with a "+" character, followed by the country code ("1" for the United States), followed by the phone number without any punctuation
    - Name of the Hifu user as "name."
    - Activity the Hifu user was engaged in as "activity."
    - Email of the emergency contact as "email.
  - Expected Request Type: JSON
  - Example Request Body:
    ``{ "phone": "+15551234567", "name": "Joe Smith", "activity": "kayaking", "email": "friend@example.com" }``
  - Response Body will come back as a string indicating the result of the action -- either that the text message was sent successfully or an explanation of the error
  - Part of the response is a text message sent to phone number indicated in request body.  
  - Response codes:
    - ``200`` Success / Text Message sent
    - ``500`` Error / Text Message not sent

**Additional Functionality**

The https://hifu-sms.herokuapp.com/sms-quickstart has been set up to handle any message that comes in to our Twilio phone number.

This endpoint shouldn't really need to be used by Hifu devs, but allows outside users to receive a response of 'Please check your email for more information. This phone number is not monitored' if they reply to our alert text message.
