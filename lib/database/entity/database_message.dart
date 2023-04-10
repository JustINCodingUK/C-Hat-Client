import 'package:c_hat/model/message/message.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "messages")
class DatabaseMessage {
  
  @PrimaryKey(autoGenerate: true)
  final int? primaryKey;

  final String content;
  final String author;
  final String timestamp;
  final String recipientClientId;

  const DatabaseMessage({this.primaryKey, required this.content, required this.author, required this.timestamp, required this.recipientClientId});

  Message toDomainModel() {
    return Message(content: content, time: timestamp, recipientClientId: recipientClientId, author: author);
  }
}