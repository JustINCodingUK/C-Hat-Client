import 'package:floor/floor.dart';

import '../../model/user/user.dart';

@Entity(tableName: "users")
class DatabaseUser {
  @primaryKey
  final String clientId;
  final String username;

  const DatabaseUser({required this.clientId, required this.username});

  User toDomainModel() {
    return User(username: username, clientId: clientId);
  }
}