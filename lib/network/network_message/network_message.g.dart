// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_message.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class NetworkMessage {
  final Event event;
  final String content;
  final String author;
  final String timestamp;
  final String recipientClientId;

  const NetworkMessage({
    required this.event,
    required this.content,
    required this.author,
    required this.timestamp,
    required this.recipientClientId,
  });

  factory NetworkMessage.fromJson(dynamic jsonData) {
    return NetworkMessage(event: mapToEvent(jsonData["event"]), content: jsonData["message"], author: jsonData["author"], timestamp: jsonData["time"], recipientClientId: jsonData["rcid"]);
  }


  @override
  String toString() {
    return 'NetworkMessage event = $event, content = $content, author = $author, timestamp = $timestamp, recipientClientId = $recipientClientId';
  }

  bool equals(NetworkMessage networkmessage) {
    if (event == networkmessage.event &&
        content == networkmessage.content &&
        author == networkmessage.author &&
        timestamp == networkmessage.timestamp &&
        recipientClientId == networkmessage.recipientClientId) {
      return true;
    } else {
      return false;
    }
  }

  NetworkMessage copy(
      {Event? event,
      String? content,
      String? author,
      String? timestamp,
      String? recipientClientId}) {
    return NetworkMessage(
        event: event ?? this.event,
        content: content ?? this.content,
        author: author ?? this.author,
        timestamp: timestamp ?? this.timestamp,
        recipientClientId: recipientClientId ?? this.recipientClientId);
  }
}
