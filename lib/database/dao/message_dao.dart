import 'package:c_hat/database/entity/database_message.dart';
import 'package:floor/floor.dart';

@dao
abstract class MessageDao {

  @insert
  Future<void> insertMessage(DatabaseMessage message);

  @delete
  Future<void> deleteMessage(DatabaseMessage message);

  @delete
  Future<void> editMessage(DatabaseMessage message);

  @Query("SELECT * FROM messages WHERE recipientClientId = :clientId")
  Future<List<DatabaseMessage>?> getMessagesByUserClientId(String clientId);

  @Query("SELECT TOP 1 * FROM messages WHERE recipientClientId = :clientId")
  Future<DatabaseMessage?> getLatestMessageByUserClientId(String clientId);

  @Query("SELECT COUNT(recipientClientId) FROM messages WHERE isUnread = TRUE AND recipientClientId = :clientId")
  Future<int?> getNumberOfUnreadMessagesByUser(String clientId);

  @Query("UPDATE messages SET isUnread = FALSE WHERE isUnread = TRUE AND recipientClientId = :clientId")
  Future<void> markUnreadAsReadOfUser(String clientId);

}