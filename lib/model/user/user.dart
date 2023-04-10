import 'package:annotations/annotations.dart';
import 'package:c_hat/database/entity/database_user.dart';

part 'user.g.dart';

@dataClass
// ignore: unused_element
class _AbsUser {
  late String username;
  late String clientId;
}

extension UserUtils on User {
  DatabaseUser toDatabaseModel() {
    return DatabaseUser(clientId: clientId, username: username);
  }
}