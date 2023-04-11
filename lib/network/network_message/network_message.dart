import 'dart:convert' as json;

import 'package:annotations/annotations.dart';
import 'package:c_hat/model/message/message.dart';
import 'package:c_hat/network/event/network_event.dart';

part 'network_message.g.dart';

@dataClass
//ignore: unused_element
class _AbsNetworkMessage {
  late Event event;
  late String content;
  late String author;
  late String timestamp;
  late String recipientClientId;
}

extension NetworkMessageUtils on NetworkMessage {
  Message toDomainModel() {
    return Message(
      content: content, 
      time: timestamp, 
      recipientClientId: recipientClientId, 
      author: author,
      isUnread: true
    );
  }

  String toJson() {
    return json.jsonEncode({
      "event": event.stringRepresentation(),
      "message": content,
      "time": timestamp,
      "rcid": recipientClientId,
      "author": author
    });
  }
}