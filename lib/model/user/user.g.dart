// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

class User {
  final String username;
  final String clientId;

  const User({
    required this.username,
    required this.clientId,
  });

  @override
  String toString() {
    return username;
  }

  bool equals(User user) {
    if (username == user.username && clientId == user.clientId) {
      return true;
    } else {
      return false;
    }
  }
  
  User copy({String? username, String? clientId}) {
    return User(
        username: username ?? this.username,
        clientId: clientId ?? this.clientId);
  }
}
