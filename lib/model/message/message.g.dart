// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class Message {
  final String content;
  final String time;
  final String recipientClientId;
  final String author;

  const Message({
    required this.content,
    required this.time,
    required this.recipientClientId,
    required this.author,
  });

  @override
  String toString() {
    return 'Message content = $content, time = $time, recipientClientId = $recipientClientId, author = $author';
  }

  bool equals(Message message) {
    if (content == message.content &&
        time == message.time &&
        recipientClientId == message.recipientClientId &&
        author == message.author) {
      return true;
    } else {
      return false;
    }
  }

  Message copy(
      {String? content,
      String? time,
      String? recipientClientId,
      String? author}) {
    return Message(
        content: content ?? this.content,
        time: time ?? this.time,
        recipientClientId: recipientClientId ?? this.recipientClientId,
        author: author ?? this.author);
  }
}
