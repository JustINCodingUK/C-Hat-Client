import 'dart:async';

import 'package:c_hat/database/chat_database.dart';
import 'package:c_hat/model/message/message.dart';
import 'package:c_hat/network/event/network_event.dart';
import 'package:c_hat/network/network_message/network_message.dart';
import 'package:c_hat/network/websocket_client/chat_websocket_client.dart';

class MessageRepository {

  final ChatDatabase _database;
  final ChatWebsocketClient _wsClient;

  MessageRepository(this._database, this._wsClient);
  
  Future<void> onMessageReceived(void Function(Message message) onReceiveCallback) async {
    _wsClient.onMessageReceive((message) async { 
      var modifiedMessage = message.copy(recipientClientId: message.author);
      await saveMessage(modifiedMessage.toDomainModel());
      onReceiveCallback(message.toDomainModel());
    });
  }

  void sendMessage(Message message) async {
    _wsClient.sendMessage(message.toNetworkModel(Event.message));
    await saveMessage(message);
  }

  Future<void> saveMessage(Message message) async {
    await _database.messageDao.insertMessage(message.toDatabaseModel());
  }

  Future<void> deleteMessage(Message message) async {
    await _database.messageDao.deleteMessage(message.toDatabaseModel());
  }

  Future<void> editMessage(Message message) async {
    await _database.messageDao.editMessage(message.toDatabaseModel());
  }

  Future<List<Message>> getMessagesByUserClientId(String clientId) async {
    final messages = await _database.messageDao.getMessagesByUserClientId(clientId);
    if(messages == null){
      return [];
    } else {
      return messages.map((message) => message.toDomainModel()).toList();
    }
  }

  Future<Message> getLatestMessageByUserClientId(String clientId) async {
    final message = await _database.messageDao.getLatestMessageByUserClientId(clientId);
    return message!.toDomainModel();
  }


}