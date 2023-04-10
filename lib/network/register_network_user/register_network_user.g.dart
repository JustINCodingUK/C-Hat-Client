// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_network_user.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class RegisterNetworkUser {
  final String mailId;
  final String username;
  final String password;

  const RegisterNetworkUser({
    required this.mailId,
    required this.username,
    required this.password,
  });

  @override
  String toString() {
    return 'RegisterNetworkUser mailId = $mailId, username = $username, password = $password';
  }

  bool equals(RegisterNetworkUser registernetworkuser) {
    if (mailId == registernetworkuser.mailId &&
        username == registernetworkuser.username &&
        password == registernetworkuser.password) {
      return true;
    } else {
      return false;
    }
  }

  RegisterNetworkUser copy(
      {String? mailId, String? username, String? password}) {
    return RegisterNetworkUser(
        mailId: mailId ?? this.mailId,
        username: username ?? this.username,
        password: password ?? this.password);
  }
}
