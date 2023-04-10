import 'package:c_hat/model/message/message.dart';

abstract class ChatEvent {}

class MessageReceivedEvent extends ChatEvent {
  final Message message;
  MessageReceivedEvent(this.message);
}

class MessageSentEvent extends ChatEvent {
  final Message message;
  MessageSentEvent(this.message);
}

class InitiateConnectionEvent extends ChatEvent {
  final String mailId;
  final String password;
  final String wsUrl;

  InitiateConnectionEvent({required this.mailId, required this.wsUrl, required this.password});
}

class MessagesRequestedEvent extends ChatEvent {
  final String clientId;
  MessagesRequestedEvent(this.clientId);
}

class LatestMessageRequestedEvent extends ChatEvent {
  final String clientId;
  LatestMessageRequestedEvent(this.clientId);
}

class LoginCompletedEvent extends ChatEvent {
  final String password;
  final String mailId;
  final String wsUrl;

  LoginCompletedEvent({required this.password, required this.mailId, required this.wsUrl});
}


