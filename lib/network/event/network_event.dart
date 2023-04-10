enum Event {
  none,
  message,
  auth,
  register,
  info,
  confirmation;

  String stringRepresentation() {
    return toString().replaceAll("Event.", "");
  }
}


Event mapToEvent(String eventString) {

    Event event = Event.none;

    switch(eventString){
      case "message": 
        event = Event.message;
        break;
      case "auth": 
        event = Event.auth;
        break;
      case "register": 
        event = Event.register;
        break;
      case "info": 
        event = Event.info;
        break;
      case "confirmation": 
        event = Event.confirmation;
        break;
    }

    return event;
  }