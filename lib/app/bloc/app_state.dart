abstract class AppState {}

class UserIsLoggedIn extends AppState {
  final String password;
  final String mailId;
  final String wsUrl;

  UserIsLoggedIn({required this.password, required this.mailId, required this.wsUrl});
}

class UserIsNotLoggedIn extends AppState {}

class LoginCheckAwaits extends AppState {}