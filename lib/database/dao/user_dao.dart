import 'package:c_hat/database/entity/database_user.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {

  @insert
  Future<void> insertUser(DatabaseUser user);

  @delete
  Future<void> deleteUser(DatabaseUser user);

  @update
  Future<void> editUser(DatabaseUser user);

  @Query("SELECT * FROM users")
  Future<List<DatabaseUser>?> getAllUsers();
}