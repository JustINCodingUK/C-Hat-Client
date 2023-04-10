import 'package:c_hat/database/chat_database.dart';

import '../model/user/user.dart';

class UserRepository {

  final ChatDatabase _database;

  const UserRepository(this._database);

  Future<void> addUser(User user) async {
    await _database.userDao.insertUser(user.toDatabaseModel());
  }

  Future<void> removeUser(User user) async {
    await _database.userDao.deleteUser(user.toDatabaseModel());
  }

  Future<void> editUser(User user) async {
    await _database.userDao.editUser(user.toDatabaseModel());
  }

  Future<List<User>> getAllUsers() async {
    final users = await _database.userDao.getAllUsers();
    return users?.map((e) => e.toDomainModel()).toList() ?? [];
  }

}