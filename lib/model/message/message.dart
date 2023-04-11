import 'package:annotations/annotations.dart';
import 'package:c_hat/database/entity/database_message.dart';

import '../../network/event/network_event.dart';
import '../../network/network_message/network_message.dart';

part 'message.g.dart';

@dataClass
// ignore: unused_element
class _AbsMessage {
  late String content;
  late String time;
  late String recipientClientId;
  late String author;
  late bool isUnread;
}

extension MessageUtils on Message {
  DatabaseMessage toDatabaseModel() {
    return DatabaseMessage(content: content, author: author, timestamp: time, recipientClientId: recipientClientId, isUnread: isUnread);
  }

  NetworkMessage toNetworkModel(Event event) {
    return NetworkMessage(event: event, content: content, author: author, timestamp: time, recipientClientId: recipientClientId);
  }
}