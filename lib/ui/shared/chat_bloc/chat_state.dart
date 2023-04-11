import 'package:c_hat/model/message/message.dart';

import '../../../model/user/user.dart';

abstract class ChatState {}

class MessageReceivedState extends ChatState {
  final Message message;

  MessageReceivedState(this.message);
}

class MessageIdleState extends ChatState {}

class LoginWait extends ChatState {
  LoginWait();
}

class LoginSuccess extends ChatState {
  final User user;
  LoginSuccess(this.user);
}

class LoginFailed extends ChatState {
  final String message;
  LoginFailed(this.message);
}

class MessagesReceivedFromDatabase extends ChatState {
  final List<Message> messages;
  MessagesReceivedFromDatabase(this.messages);
}

class LatestMessageReceived extends ChatState {
  final Message message;
  LatestMessageReceived(this.message);
}

class NumberOfUnreadMessagesReceived extends ChatState {
  final int numberOfUnreadMessages;
  final String clientId;
  NumberOfUnreadMessagesReceived({required this.numberOfUnreadMessages, required this.clientId});
}