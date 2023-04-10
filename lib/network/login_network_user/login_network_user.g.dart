// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_network_user.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class LoginNetworkUser {
  final String mailId;
  final String password;

  const LoginNetworkUser({
    required this.mailId,
    required this.password,
  });

  @override
  String toString() {
    return 'LoginNetworkUser mailId = $mailId, password = $password';
  }

  bool equals(LoginNetworkUser loginnetworkuser) {
    if (mailId == loginnetworkuser.mailId &&
        password == loginnetworkuser.password) {
      return true;
    } else {
      return false;
    }
  }

  LoginNetworkUser copy({String? mailId, String? password}) {
    return LoginNetworkUser(
        mailId: mailId ?? this.mailId, password: password ?? this.password);
  }
}
