**Purpose**

This microservice is used to connect the Hifu API to Twilio SMS text messaging service.

**Production Endpoints**

*Send Alert to Emergency Contact*

https://hifu-sms.herokuapp.com/alert

  - Required in Request: phone, name, activity, and email
  - Example Request Body:
    ``{ "phone": "+13038758190", "name": "Krista Stadler", "activity": "kayaking", "email": "friend@example.com" }``
