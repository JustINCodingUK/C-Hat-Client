import 'dart:async';

import 'package:c_hat/database/dao/message_dao.dart';
import 'package:c_hat/database/dao/user_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entity/database_message.dart';
import 'entity/database_user.dart';

part 'chat_database.g.dart';

@Database(version: 1, entities: [DatabaseMessage, DatabaseUser])
abstract class ChatDatabase extends FloorDatabase {
  MessageDao get messageDao;
  UserDao get userDao;
}

ChatDatabase? _instance;

Future<ChatDatabase> getDatabase() async {
  _instance ??= await $FloorChatDatabase.databaseBuilder("c_hat_database").build();
  return _instance!;
}