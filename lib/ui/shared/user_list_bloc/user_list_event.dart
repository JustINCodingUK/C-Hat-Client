import 'package:c_hat/model/user/user.dart';

abstract class UserListEvent {}

class UserAddEvent extends UserListEvent {
  final User user;
  UserAddEvent(this.user);
}

class UserDeleteEvent extends UserListEvent {
  final User user;
  UserDeleteEvent(this.user);
}

class UserEditEvent extends UserListEvent {
  final User user;
  UserEditEvent(this.user);
}

class AllUsersRequestedFromDatabaseEvent extends UserListEvent {}
